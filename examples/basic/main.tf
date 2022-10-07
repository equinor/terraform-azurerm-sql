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

module "sql" {
  # source = "github.com/equinor/terraform-azurerm-sql?ref=v0.0.0"
  source = "../.."

  server_name             = "sql-${random_id.this.hex}"
  resource_group_name     = azurerm_resource_group.this.name
  location                = azurerm_resource_group.this.location
  storage_account_name    = "st${random_id.this.hex}sql"
  admin_login             = "masterlogin"
  azuread_admin_login     = "john.smith@example.com"
  azuread_admin_object_id = data.azurerm_client_config.current.object_id

  databases = {
    "this" = {
      name = "sqldb-${random_id.this.hex}"
    }
  }
}
