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
  administrator_login  = "masterlogin"
  sku_name             = "Basic"
  max_size_gb          = 2

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

  security_alert_policy_email_account_admins = true
  security_alert_policy_email_addresses      = []
  short_term_retention_policy_retention_days           = 7
  short_term_retention_policy_backup_interval_in_hours = 12

  long_term_retention_policy_weekly_retention  = "PT0S"
  long_term_retention_policy_monthly_retention = "PT0S"
  long_term_retention_policy_yearly_retention  = "PT0S"

  tags = local.tags
}
