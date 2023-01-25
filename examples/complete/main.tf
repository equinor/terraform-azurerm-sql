provider "azurerm" {
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

module "sql" {
  # source = "github.com/equinor/terraform-azurerm-sql?ref=v0.0.0"
  source = "../.."

  database_name        = "sqldb-${random_id.this.hex}"
  server_name          = "sql-${random_id.this.hex}"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  storage_account_name = "st${random_id.this.hex}sql"
  admin_login          = "masterlogin"

  azuread_administrator = {
    login_username = "azureadmasterlogin"
    object_id      = data.azurerm_client_config.current.object_id
  }

  firewall_rules = {
    "azure" = {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }

  tags = local.tags
}
