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

  dynamic "azuread_administrator" {
    for_each = var.azuread_admin != null ? [var.azuread_admin] : []
    iterator = i

    content {
      login_username = i.value.user_principal_name
      object_id      = i.value.object_id
    }
  }

  lifecycle {
    ignore_changes = [
      # Allow admin password to be updated outside of Terraform.
      administrator_login_password
    ]
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

module "database" {
  source = "./modules/database"

  name                  = var.database_name
  server_id             = azurerm_mssql_server.this.id
  sku_name              = var.sku_name
  pitr_retention_days   = var.pitr_retention_days
  ltr_weekly_retention  = var.ltr_weekly_retention
  ltr_monthly_retention = var.ltr_monthly_retention
  ltr_yearly_retention  = var.ltr_yearly_retention

  tags = var.tags
}
