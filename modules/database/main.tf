locals {
  resource_group_name = provider::azurerm::parse_resource_id(var.server_id).resource_group_name

  diagnostic_setting_metric_categories = ["Basic", "InstanceAndAppAdvanced", "WorkloadManagement"]

  metric_alerts = {
    "storage_percent" = {
      name        = "High storage usage"
      description = ""
      metric_name = "storage_percent"
      aggregation = "Maxium"
      operator    = "GreaterThan"
      threshold   = 80
      frequency   = "PT1M"
      window_size = "PT5M"
      severity    = 2
    }

    "cpu_percent" = {
      name        = "High CPU usage"
      description = ""
      metric_name = "cpu_percent"
      aggregation = "Average"
      operator    = "GreaterThan"
      threshold   = 80
      frequency   = "PT1M"
      window_size = "PT5M"
      severity    = 2
    }
  }
}

resource "azurerm_mssql_database" "this" {
  name                           = var.database_name
  server_id                      = var.server_id
  elastic_pool_id                = var.elastic_pool_id
  collation                      = var.collation
  enclave_type                   = var.enclave_type
  maintenance_configuration_name = var.elastic_pool_id == null ? var.maintenance_configuration_name : null # Conflicts with elastic pool
  ledger_enabled                 = var.ledger_enabled
  license_type                   = var.license_type
  max_size_gb                    = var.max_size_gb
  sku_name                       = var.elastic_pool_id == null ? var.sku_name : "ElasticPool"
  storage_account_type           = var.storage_account_type

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
    for_each = toset(concat(local.diagnostic_setting_metric_categories, var.diagnostic_setting_enabled_metric_categories))

    content {
      # Azure expects explicit configuration of both enabled and disabled metric categories.
      category = metric.value
      enabled  = contains(var.diagnostic_setting_enabled_metric_categories, metric.value)
    }
  }
}

resource "azurerm_monitor_metric_alert" "this" {
  for_each = local.metric_alerts

  name                = "${each.value.name} - ${azurerm_mssql_database.this.name}"
  resource_group_name = local.resource_group_name
  scopes              = [azurerm_mssql_database.this.id]
  description         = each.value.description

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  frequency   = each.value.frequency
  window_size = each.value.window_size
  severity    = each.value.severity

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}
