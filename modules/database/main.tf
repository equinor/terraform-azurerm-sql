resource "azurerm_mssql_database" "this" {
  name                 = var.name
  server_id            = var.server_id
  sku_name             = var.sku_name
  max_size_gb          = var.max_size_gb
  storage_account_type = var.storage_account_type

  short_term_retention_policy {
    retention_days           = var.short_term_retention_policy_retention_days
    backup_interval_in_hours = var.short_term_retention_policy_backup_interval_in_hours
  }

  long_term_retention_policy {
    weekly_retention  = var.long_term_retention_policy_weekly_retention
    monthly_retention = var.long_term_retention_policy_monthly_retention
    yearly_retention  = var.long_term_retention_policy_yearly_retention
    week_of_year      = var.long_term_retention_policy_week_of_year
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                           = var.diagnostic_setting_name
  target_resource_id             = azurerm_mssql_database.this.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}
