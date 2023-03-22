provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
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
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.3.1"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

}

module "sql" {
  # source = "github.com/equinor/terraform-azurerm-sql?ref=v0.0.0"
  source = "../.."

  database_name              = "sqldb-${random_id.this.hex}"
  server_name                = "sql-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  storage_account_name       = "st${random_id.this.hex}sql"
  administrator_login        = "masterlogin"
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
