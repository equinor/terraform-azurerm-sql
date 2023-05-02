locals {
  azuread_authentication_only = var.azuread_administrator != null ? var.azuread_administrator["azuread_authentication_only"] : false
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
  administrator_login          = local.azuread_authentication_only ? null : var.administrator_login
  administrator_login_password = local.azuread_authentication_only ? null : random_password.this.result
  minimum_tls_version          = "1.2"

  tags = var.tags

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator != null ? [var.azuread_administrator] : []

    content {
      login_username              = azuread_administrator.value["login_username"]
      object_id                   = azuread_administrator.value["object_id"]
      azuread_authentication_only = azuread_administrator.value["azuread_authentication_only"]
    }
  }

  lifecycle {
    ignore_changes = [
      # Allow admin password to be updated outside of Terraform.
      administrator_login_password
    ]
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }
}

resource "azurerm_mssql_firewall_rule" "this" {
  for_each = var.firewall_rules

  name             = each.value.name
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

resource "azurerm_mssql_failover_group" "this" {
  for_each = var.failover_groups

  name      = each.value["name"]
  server_id = azurerm_mssql_server.this.id

  partner_server {
    id = each.value["partner_server_id"]
  }

  databases = each.value["databases"]

  readonly_endpoint_failover_policy_enabled = each.value["readonly_endpoint_failover_policy_enabled"]

  read_write_endpoint_failover_policy {
    mode          = each.value["read_write_endpoint_failover_policy_mode"]
    grace_minutes = each.value["read_write_endpoint_failover_policy_grace_minutes"]
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id              = azurerm_mssql_server.this.id
  log_monitoring_enabled = true
}

# Create diagnostic setting for master database to enable server wide.
resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = "${azurerm_mssql_server.this.id}/databases/master"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "Basic"
    enabled  = false

    retention_policy {
      enabled = false
      days    = 0
    }
  }

  metric {
    category = "InstanceAndAppAdvanced"
    enabled  = false

    retention_policy {
      enabled = false
      days    = 0
    }
  }

  metric {
    category = "WorkloadManagement"
    enabled  = false

    retention_policy {
      enabled = false
      days    = 0
    }
  }

  depends_on = [
    # Wait for server extended auditing policy to be created.
    # This ensures the master database exists before trying to create a diagnostic setting for it.
    azurerm_mssql_server_extended_auditing_policy.this
  ]
}

resource "azurerm_mssql_server_security_alert_policy" "this" {
  resource_group_name  = azurerm_mssql_server.this.resource_group_name
  server_name          = azurerm_mssql_server.this.name
  state                = "Enabled"
  disabled_alerts      = []
  email_addresses      = var.security_alert_policy_email_addresses
  email_account_admins = var.security_alert_policy_email_account_admins
}

resource "azurerm_mssql_server_vulnerability_assessment" "this" {
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.this.id
  storage_container_path          = "${var.storage_blob_endpoint}${var.storage_container_name}/"
  storage_account_access_key      = var.storage_account_access_key

  recurring_scans {
    enabled                   = var.recurring_scan_setting
    email_subscription_admins = var.email_subscription_admins
    emails                    = var.email_ids
  }
}
