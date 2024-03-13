provider "azurerm" {
  storage_use_azuread = true

  features {}
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
  # version = "0.0.0"
  source = "../.."

  server_name                = "sql-${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
  storage_account_id         = module.storage.account_id
  storage_blob_endpoint      = module.storage.blob_endpoint

  azuread_administrator_login_username = "azureadadminlogin"
  azuread_administrator_object_id      = data.azurerm_client_config.current.object_id
}

module "database" {
  # source  = "equinor/sql/azurerm//modules/database"
  # version = "0.0.0"
  source = "../../modules/database"

  database_name              = "sqldb-${random_id.this.hex}"
  server_id                  = module.sql.server_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
