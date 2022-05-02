provider "azurerm" {
  features {}
}

locals {
  application = random_id.this.hex
  environment = "test"
}

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

  azuread_admin_name      = "AzureAD Admins"
  azuread_admin_object_id = "6d8487a5-a115-458b-8ae8-c34783b17242"
}

resource "azurerm_mssql_firewall_rule" "this" {
  name             = "FirewallRule1"
  server_id        = module.sql.sql_server_id
  start_ip_address = "10.0.17.62"
  end_ip_address   = "10.0.17.62"
}

resource "azurerm_mssql_database" "this" {
  name      = "sqldb-${local.application}-${local.environment}"
  server_id = module.sql.sql_server_id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
}
