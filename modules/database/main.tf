resource "azurerm_mssql_database" "this" {
  name           = coalesce(var.database_name, replace(lower("sqldb-${var.application}-${var.environment}"), "/[^a-z0-9-]+/", ""))
  server_id      = var.server_id
  sku_name       = var.sku_name
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  zone_redundant = var.zone_redundant

  short_term_retention_policy {
    retention_days           = var.pitr_retention_days
    backup_interval_in_hours = 12
  }

  long_term_retention_policy {
    weekly_retention  = var.ltr_weekly_duration
    monthly_retention = var.ltr_monthly_duration
    yearly_retention  = var.ltr_yearly_duration
    week_of_year      = var.ltr_week_of_year
  }

  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}
