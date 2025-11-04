# Generate random password based on Azure SQL password policy.
# Ref: https://learn.microsoft.com/en-us/sql/relational-databases/security/password-policy
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
  name                                     = var.server_name
  location                                 = var.location
  resource_group_name                      = var.resource_group_name
  version                                  = "12.0"
  administrator_login                      = var.azuread_authentication_only ? null : var.administrator_login
  administrator_login_password             = var.azuread_authentication_only ? null : random_password.this.result
  minimum_tls_version                      = "1.2"
  express_vulnerability_assessment_enabled = true

  tags = var.tags

  azuread_administrator {
    login_username              = var.azuread_administrator_login_username
    object_id                   = var.azuread_administrator_object_id
    azuread_authentication_only = var.azuread_authentication_only
  }

  lifecycle {
    ignore_changes = [
      # Allow admin password to be updated outside of Terraform.
      administrator_login_password
    ]
  }

  identity {
    type         = length(var.identity_ids) > 0 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.identity_ids
  }
}

resource "azurerm_mssql_firewall_rule" "this" {
  for_each = merge(local.firewall_rules, var.firewall_rules)

  name             = each.value.name
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id              = azurerm_mssql_server.this.id
  log_monitoring_enabled = true

  # The following arguments are irrelevant when log_monitoring_enabled = true:
  storage_endpoint                        = null
  storage_account_access_key              = null
  storage_account_access_key_is_secondary = null
  storage_account_subscription_id         = null
  retention_in_days                       = null
}

# Create diagnostic setting for master database to enable server wide.
resource "azurerm_monitor_diagnostic_setting" "server" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = "${azurerm_mssql_server.this.id}/databases/master"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }

  # Metrics are not supported at the master database scope.

  depends_on = [
    # Wait for server extended auditing policy to be created.
    # This ensures the master database exists before trying to create a diagnostic setting for it.
    azurerm_mssql_server_extended_auditing_policy.this
  ]
}
