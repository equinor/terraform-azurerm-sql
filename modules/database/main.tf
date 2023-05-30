resource "azurerm_mssql_database" "this" {
  name                 = var.database_name
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
