provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "${random_id.this.hex}-rg"
  location = var.location
}

module "sql" {
  source = "../.."

  server_name          = "${random_id.this.hex}-sql"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  storage_account_name = "${random_id.this.hex}sqlst"
  admin_login          = "masterlogin"

  azuread_admin = {
    user_principal_name = "john.smith@example.com"
    object_id           = data.azurerm_client_config.current.object_id
  }

  firewall_rules = {
    "Rule1" = ["1.1.1.1", "1.1.1.1"],
    "Rule2" = ["1.1.1.1", "1.1.1.1"],
    "Rule3" = ["1.1.1.1", "1.1.1.1"]
  }
}

module "database" {
  source = "../../modules/database"

  name      = "${random_id.this.hex}-sqldb"
  server_id = module.sql.server_id
}
