locals {
  suffix       = "${var.application}-${var.environment}"
  suffix_alnum = join("", regexall("[a-z0-9]", lower(local.suffix)))

  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}

resource "azurerm_storage_account" "this" {
  name                      = coalesce(var.storage_account_name, "stsql${local.suffix_alnum}")
  location                  = var.location
  resource_group_name       = var.resource_group_name
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "BlobStorage"
  access_tier               = "Hot"
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true
  shared_access_key_enabled = true

  tags = local.tags

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
  length  = 32
  special = true
}

resource "azurerm_mssql_server" "this" {
  name                         = coalesce(var.sql_server_name, "sql-${local.suffix}")
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = "12.0"
  administrator_login          = "sql${local.suffix_alnum}"
  administrator_login_password = random_password.this.result
  minimum_tls_version          = "1.2"

  tags = local.tags

  azuread_administrator {
    login_username = var.azuread_admin_name
    object_id      = var.azuread_admin_object_id
  }
}

resource "azurerm_mssql_firewall_rule" "this" {
  for_each = merge({ "AllowAllWindowsAzureIps" = ["0.0.0.0", "0.0.0.0"] }, var.firewall_rules)

  name             = each.key
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = each.value[0]
  end_ip_address   = each.value[1]
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
