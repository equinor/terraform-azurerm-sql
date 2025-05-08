locals {
  diagnostic_setting_metric_categories = ["Basic", "InstanceAndAppAdvanced", "WorkloadManagement"]
}

resource "azurerm_mssql_database" "this" {
  name                           = var.database_name
  server_id                      = var.server_id
  elastic_pool_id                = var.elastic_pool_id
  collation                      = var.collation
  enclave_type                   = var.enclave_type
  maintenance_configuration_name = var.elastic_pool_id == null ? var.maintenance_configuration_name : null # Conflicts with elastic pool
  ledger_enabled                 = var.ledger_enabled
  max_size_gb                    = var.max_size_gb
  sku_name                       = var.elastic_pool_id == null ? var.sku_name : "ElasticPool"
  storage_account_type           = var.storage_account_type
  min_capacity                   = var.min_capacity
  auto_pause_delay_in_minutes    = var.auto_pause_delay_in_minutes

  # Should be managed by owner of existing license, usually platform team.
  license_type = null

  tags = var.tags

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
    for_each = length(var.identity_ids) > 0 ? [0] : []

    content {
      # UserAssigned identity is currently the only supported identity option
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }
  }

  lifecycle {
    # Protect database from accidental deletion
    prevent_destroy = true

    ignore_changes = [
      # Should be managed by owner of existing license, usually platform team.
      license_type
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "database" {
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
    for_each = toset(concat(local.diagnostic_setting_metric_categories, var.diagnostic_setting_enabled_metric_categories))

    content {
      # Azure expects explicit configuration of both enabled and disabled metric categories.
      category = metric.value
      enabled  = contains(var.diagnostic_setting_enabled_metric_categories, metric.value)
    }
  }
}
