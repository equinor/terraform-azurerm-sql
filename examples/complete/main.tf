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

resource "azurerm_resource_group" "this" {
  name     = "rg-${random_id.this.hex}"
  location = var.location

  tags = local.tags
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.5.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "storage" {
  source = "github.com/equinor/terraform-azurerm-storage?ref=v10.3.0"

  account_name               = "st${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

module "sql" {
  # source = "github.com/equinor/terraform-azurerm-sql?ref=v0.0.0"
  source = "../.."

  server_name                = "sql-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
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

resource "azurerm_mssql_database" "example" {
  name      = "sqldb-${random_id.this.hex}"
  server_id = module.sql.server_id
}
