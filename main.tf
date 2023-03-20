provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
name     = "var.resource_group_name"
location = "var.location"
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
  administrator_login          = var.administrator_login
  administrator_login_password = random_password.this.result
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

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id                               = azurerm_mssql_server.this.id
  storage_endpoint                        = azurerm_storage_account.this.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.this.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "var.log_analytic_workspace"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_mssql_server_security_alert_policy" "this" {
  resource_group_name = azurerm_mssql_server.this.resource_group_name
  server_name         = azurerm_mssql_server.this.name
  state               = "Enabled"
  disabled_alerts     = []
  email_addresses     = []
}

resource "azurerm_eventhub_namespace" "this" {
  name                = "var.eventhub_namespace"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"
}

resource "azurerm_eventhub" "this" {
  name                = "var.eventhub"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = azurerm_resource_group.this.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_namespace_authorization_rule" "this" {
  name                = "var.eventhub_auth_rule"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = azurerm_resource_group.this.name
  listen              = true
  send                = true
  manage              = true
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id              = azurerm_mssql_server.this.id
  log_monitoring_enabled = true
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                           = "var.diagnostic_setting"
  target_resource_id             = "${azurerm_mssql_server.this.id}/database/master"
  eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.this.id
  eventhub_name                  = azurerm_eventhub.this.name
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id

log {
  category = "SQLSecurityAudtiEvents"
  enabled  = true

  retention_policy {
    enabled = false
  }
 }

 metric {
   category = "AllMetrics"

   retention_policy {
     enabled = false
   }
 }
}

module "database" {
  source = "./modules/database"

  name                 = var.database_name
  server_id            = azurerm_mssql_server.this.id
  sku_name             = var.sku_name
  max_size_gb          = var.max_size_gb
  storage_account_type = var.database_storage_account_type

  short_term_retention_policy_retention_days           = var.short_term_retention_policy_retention_days
  short_term_retention_policy_backup_interval_in_hours = var.short_term_retention_policy_backup_interval_in_hours

  long_term_retention_policy_weekly_retention  = var.long_term_retention_policy_weekly_retention
  long_term_retention_policy_monthly_retention = var.long_term_retention_policy_monthly_retention
  long_term_retention_policy_yearly_retention  = var.long_term_retention_policy_yearly_retention
  long_term_retention_policy_week_of_year      = var.long_term_retention_policy_week_of_year

  tags = var.tags
}
