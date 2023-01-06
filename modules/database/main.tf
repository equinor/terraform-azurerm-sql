resource "azurerm_mssql_database" "this" {
  name                 = var.name
  server_id            = var.server_id
  sku_name             = var.sku_name
  storage_account_type = var.storage_account_type

  short_term_retention_policy {
    retention_days           = var.pitr_retention_days
    backup_interval_in_hours = var.str_backup_interval
  }

  long_term_retention_policy {
    weekly_retention  = var.ltr_weekly_retention
    monthly_retention = var.ltr_monthly_retention
    yearly_retention  = var.ltr_yearly_retention
    week_of_year      = var.ltr_week_of_year
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      # Ignore sku_name to allow sku to be scaled outside of terraform
      sku_name
    ]
  }
}
