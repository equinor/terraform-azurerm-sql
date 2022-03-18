locals {
  app_name_alnum = join("", regexall("[a-z0-9]", lower(var.app_name)))
}

resource "azurerm_storage_account" "this" {
  name                      = "stsql${local.app_name_alnum}${var.environment_name}"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "BlobStorage"
  access_tier               = "Hot"
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true
  allow_blob_public_access  = false
  shared_access_key_enabled = true

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
  name                         = coalesce(var.sql_name, "sql-${var.app_name}-${var.environment_name}")
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sql${var.app_name}${var.environment_name}"
  administrator_login_password = random_password.this.result
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = var.sql_server_azuread_admin.login_username
    object_id      = var.sql_server_azuread_admin.object_id
  }
}

resource "azurerm_mssql_firewall_rule" "this" {
  count = var.sql_server_firewall_allow_azure ? 1 : 0

  name             = "AllowAllWindowsAzureIps"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
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
}

resource "azurerm_storage_container" "this" {
  name                 = "vulnerability-assessments"
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
