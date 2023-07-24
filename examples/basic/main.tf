provider "azurerm" {
  storage_use_azuread = true

  features {}
}

data "azurerm_client_config" "current" {}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${random_id.this.hex}"
  location = var.location
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.5.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "storage" {
  source = "github.com/equinor/terraform-azurerm-storage?ref=v11.0.0"

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

  administrator_login = "sqladminlogin"
}

module "database" {
  # source = "github.com/equinor/terraform-azurerm-sql//modules/database?ref=v0.0.0"
  source = "../../modules/database"

  database_name = "sqldb-${random_id.this.hex}"
  server_id     = module.sql.server_id
}
