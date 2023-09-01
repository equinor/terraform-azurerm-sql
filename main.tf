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
  administrator_login          = var.azuread_authentication_only ? null : var.administrator_login
  administrator_login_password = var.azuread_authentication_only ? null : random_password.this.result
  minimum_tls_version          = "1.2"

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
  for_each = var.firewall_rules

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
  email_account_admins = var.security_alert_policy_email_account_admins
  email_addresses      = var.security_alert_policy_email_addresses
}

data "azurerm_mssql_server" "this" {
  name                = azurerm_mssql_server.this.name
  resource_group_name = azurerm_mssql_server.this.resource_group_name
}

resource "azurerm_role_assignment" "this" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_mssql_server.this.identity[0].principal_id
  # This resource sometimes throws the following error: The argument "principal_id" is required, but no definition was found.
  # To fix this issue, get "principal_id" from a data source to read its value during the the apply phase instead of the plan phase.
  # This ensures the SQL server system-assigned identity is always enabled before trying to read its principal ID.
  # Ref: https://developer.hashicorp.com/terraform/language/data-sources#data-resource-behavior
}

resource "azurerm_mssql_server_vulnerability_assessment" "this" {
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.this.id
  storage_container_path          = "${var.storage_blob_endpoint}${var.storage_container_name}/"

  recurring_scans {
    enabled                   = var.vulnerability_assessment_recurring_scans_enabled
    email_subscription_admins = var.vulnerability_assessment_recurring_scans_email_subscription_admins
    emails                    = var.vulnerability_assessment_recurring_scans_emails
  }

  depends_on = [azurerm_role_assignment.this]
}
