provider "azurerm" {
  storage_use_azuread = true

  features {}
}

locals {
  tags = {
    "Environment" = "Testing"
  }
}

data "azurerm_client_config" "current" {}

resource "random_id" "this" {
  byte_length = 8
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "2.2.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "storage" {
  source  = "equinor/storage/azurerm"
  version = "12.3.0"

  account_name               = "st${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

module "sql" {
  # source  = "equinor/sql/azurerm"
  # version = "10.2.3"
  source = "../.."

  server_name                = "sql-${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
  storage_account_id         = module.storage.account_id
  storage_blob_endpoint      = module.storage.blob_endpoint

  azuread_administrator_login_username = "azureadadminlogin"
  azuread_administrator_object_id      = data.azurerm_client_config.current.object_id
  azuread_authentication_only          = false

  administrator_login = "sqladminlogin"

  firewall_rules = {
    "azure" = {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }

  security_alert_policy_email_account_admins = true
  security_alert_policy_email_addresses      = []

  tags = local.tags
}

module "database" {
  # source  = "equinor/sql/azurerm//modules/database"
  # version = "10.2.3"
  source = "../../modules/database"

  database_name              = "sqldb-${random_id.this.hex}"
  server_id                  = module.sql.server_id
  log_analytics_workspace_id = module.log_analytics.workspace_id

  sku_name             = "Basic"
  storage_account_type = "Geo"
  max_size_gb          = 2

  short_term_retention_policy_retention_days           = 7
  short_term_retention_policy_backup_interval_in_hours = 12

  long_term_retention_policy_weekly_retention  = "PT0S"
  long_term_retention_policy_monthly_retention = "PT0S"
  long_term_retention_policy_yearly_retention  = "PT0S"
  long_term_retention_policy_week_of_year      = 1
}
