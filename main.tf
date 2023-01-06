locals {
  firewall_rule_allow_azure_ips = {
    "azure" = {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }
}

resource "azurerm_storage_account" "this" {
  name                = var.storage_account_name
  location            = var.location
  resource_group_name = var.resource_group_name

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "BlobStorage"
  access_tier              = "Hot"

  min_tls_version                 = "TLS1_2"
  enable_https_traffic_only       = true
  shared_access_key_enabled       = true
  allow_nested_items_to_be_public = false

  tags = var.tags

  blob_properties {
    delete_retention_policy {
      days = 30
    }

    container_delete_retention_policy {
      days = 30
    }

    change_feed_enabled = false
    versioning_enabled  = false
  }
}

resource "random_password" "this" {
  length      = 128
  lower       = true
  upper       = true
  numeric     = true
  special     = true
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

resource "azurerm_mssql_server" "this" {
  name                         = var.server_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = random_password.this.result
  minimum_tls_version          = "1.2"

  tags = var.tags

  azuread_administrator {
    login_username              = var.azuread_admin_login
    object_id                   = var.azuread_admin_object_id
    azuread_authentication_only = var.azuread_authentication_only
  }

  lifecycle {
    ignore_changes = [
      # Allow admin password to be updated outside of Terraform.
      administrator_login_password
    ]
  }
}

resource "azurerm_mssql_firewall_rule" "this" {
  for_each = var.firewall_azure_ips_allowed ? merge(local.firewall_rule_allow_azure_ips, var.firewall_rules) : var.firewall_rules

  name             = each.value.name
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id                               = azurerm_mssql_server.this.id
  storage_endpoint                        = azurerm_storage_account.this.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.this.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
}

resource "azurerm_mssql_server_security_alert_policy" "this" {
  resource_group_name = azurerm_mssql_server.this.resource_group_name
  server_name         = azurerm_mssql_server.this.name
  state               = "Enabled"
  disabled_alerts     = []
  email_addresses     = []
}

resource "azurerm_storage_container" "this" {
  name                 = "vulnerability-assessment"
  storage_account_name = azurerm_storage_account.this.name
}

resource "azurerm_mssql_server_vulnerability_assessment" "this" {
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.this.id
  storage_container_path          = "${azurerm_storage_account.this.primary_blob_endpoint}${azurerm_storage_container.this.name}/"
  storage_account_access_key      = azurerm_storage_account.this.primary_access_key

  recurring_scans {
    enabled                   = true
    email_subscription_admins = false
    emails                    = []
  }
}

module "database" {
  for_each = var.databases
  source   = "./modules/database"

  name                  = each.value.name
  server_id             = azurerm_mssql_server.this.id
  sku_name              = each.value.sku_name
  pitr_retention_days   = each.value.pitr_retention_days
  ltr_weekly_retention  = each.value.ltr_weekly_retention
  ltr_monthly_retention = each.value.ltr_monthly_retention
  ltr_yearly_retention  = each.value.ltr_yearly_retention
  ltr_week_of_year      = each.value.ltr_week_of_year
  str_backup_interval   = each.value.str_backup_interval

  tags = var.tags
}
