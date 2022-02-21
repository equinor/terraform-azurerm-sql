provider "azurerm" {
  features {}
}

locals {
  app_name         = "ops"
  environment_name = "example"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.app_name}-${local.environment_name}"
  location = "northeurope"
}

module "sql" {
  source = "../.."

  app_name            = local.app_name
  environment_name    = local.environment_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  sql_server_azuread_admin = {
    login_username = "AzureAD Admin"
    object_id      = "6d8487a5-a115-458b-8ae8-c34783b17242"
  }
}

resource "azurerm_mssql_firewall_rule" "this" {
  name             = "FirewallRule1"
  server_id        = module.sql.sql_server_id
  start_ip_address = "10.0.17.62"
  end_ip_address   = "10.0.17.62"
}

resource "azurerm_mssql_database" "this" {
  name      = "sqldb-${local.app_name}-${local.environment_name}"
  server_id = module.sql.sql_server_id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
}
