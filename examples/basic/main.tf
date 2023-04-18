provider "azurerm" {
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
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.4.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

}

module "sql" {
  # source = "github.com/equinor/terraform-azurerm-sql?ref=v0.0.0"
  source = "../.."

  server_name                = "sql-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  administrator_login        = "masterlogin"
  log_analytics_workspace_id = module.log_analytics.workspace_id
  storage_account_name       = "st${random_id.this.hex}sql"
}

module "database" {
  # source = "github.com/equinor/terraform-azurerm-sql//modules/database?ref=v0.0.0"
  source = "../../modules/database"

  name      = "sqldb-${random_id.this.hex}"
  server_id = module.sql.server_id
}
