provider "azurerm" {
  features {}
}

locals {
  application = random_id.this.hex
  environment = "test"
}

data "azurerm_client_config" "current" {}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.application}-${local.environment}"
  location = var.location
}

module "sql" {
  source = "../.."

  application = local.application
  environment = local.environment

  storage_account_name = "st${local.application}sql001"

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  azuread_admin_login     = "john.smith@example.com"
  azuread_admin_object_id = data.azurerm_client_config.current.object_id # Must be a real object ID within the current tenant.

  firewall_rules = {
    "Rule1" = ["1.1.1.1", "1.1.1.1"]
    "Rule2" = ["2.2.2.2", "2.2.2.2"]
    "Rule3" = ["3.3.3.3", "3.3.3.3"]
  }
}
