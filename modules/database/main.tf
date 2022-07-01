locals {
  suffix       = "${var.application}-${var.environment}"
  suffix_alnum = join("", regexall("[a-z0-9]", lower(local.suffix)))

  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}

resource "random_password" "this" {
  length  = 32
  special = true
}

resource "azurerm_mssql_server" "this" {
  name                         = coalesce(var.server_name, "sql-${local.suffix}")
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sql${local.suffix_alnum}"
  administrator_login_password = random_password.this.result

  tags = var.tags
}

resource "azurerm_mssql_database" "this" {
  name      = coalesce(var.server_name, "sqldb-${local.suffix}")
  server_id = azurerm_mssql_server.this.id

  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 4

  read_scale     = true
  sku_name       = "S0"
  zone_redundant = var.zone_redundancy

  long_term_retention_policy {
    week_of_year      = 26
    monthly_retention = "P3W"
  }

  short_term_retention_policy {
    retention = 7
  }

  tags = var.tags
}
