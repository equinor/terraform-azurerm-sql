resource "azurerm_mssql_database" "this" {
  name                           = var.database_name
  server_id                      = var.server_id
  elastic_pool_id                = var.elastic_pool_id
  collation                      = var.collation
  enclave_type                   = var.enclave_type
  maintenance_configuration_name = var.elastic_pool_id == null ? var.maintenance_configuration_name : null # Conflifcts with elastic pool
  ledger_enabled                 = var.ledger_enabled
  license_type                   = var.license_type
  max_size_gb                    = var.max_size_gb
  sku_name                       = var.sku_name
  storage_account_type           = var.storage_account_type

  tags = var.tags
  dynamic "long_term_retention_policy" {
    for_each = var.long_term_retention_policy != null ? [var.long_term_retention_policy] : []
    content {
      weekly_retention  = long_term_retention_policy.value.weekly_retention
      monthly_retention = long_term_retention_policy.value.monthly_retention
      yearly_retention  = long_term_retention_policy.value.yearly_retention
      week_of_year      = long_term_retention_policy.value.week_of_year
    }
  }
  # Might be irrelevant when threat detection is configured at the server level.
  # Might be relevant for serverless databases. If this is true, variables can be created.
  threat_detection_policy {
    state                = "Disabled"
    disabled_alerts      = []
    email_account_admins = "Disabled"
    email_addresses      = []
    retention_days       = 0
  }

  dynamic "identity" {
    for_each = length(var.identities) > 0 ? ["identity"] : []
    content {
      # UserAssigned identity is currently the only supported identity option
      type         = "UserAssigned"
      identity_ids = var.identities
    }
  }

  lifecycle {
    # Protect database from accidental deletion
    prevent_destroy = true
  }

}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = azurerm_mssql_database.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = toset(var.diagnostic_setting_enabled_metric_categories)

    content {
      category = metric.value
    }
  }

  depends_on = [
    azurerm_mssql_database.this
  ]
}
