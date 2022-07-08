resource "azurerm_mssql_database" "this" {
  name           = coalesce(var.database_name, replace(lower("sqldb-${var.application}-${var.environment}"), "/[^a-z0-9-]+/", ""))
  server_id      = var.server_id
  sku_name       = var.sku_name
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  zone_redundant = var.zone_redundancy

  long_term_retention_policy {
    week_of_year      = 26
    monthly_retention = "P3W"
  }

  short_term_retention_policy {
    retention = 7
  }

  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}
