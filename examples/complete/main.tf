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

  database_name              = "sqldb-${random_id.this.hex}"
  server_name                = "sql-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  storage_account_name       = "st${random_id.this.hex}sql"
  storage_container_name     = "st-container-${random_id.this.hex}-sql"
  admin_login                = "masterlogin"
  azuread_admin_login        = "john.smith@example.com"
  azuread_admin_object_id    = data.azurerm_client_config.current.object_id
  firewall_azure_ips_allowed = true

  firewall_rules = {
    "office" = {
      name             = "AllowAllOfficeIps"
      start_ip_address = "1.1.1.1"
      end_ip_address   = "1.1.1.1"
    }
  }

  tags = local.tags
}
