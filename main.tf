module "server" {
  source = "./modules/server"

  server_name           = var.server_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  administrator_login   = var.administrator_login
  azuread_administrator = var.azuread_administrator
  identity              = var.identity

  firewall_rules = var.firewall_rules

  security_alert_policy_email_addresses      = var.security_alert_policy_email_addresses
  security_alert_policy_email_account_admins = var.security_alert_policy_email_account_admins

  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name

  tags = var.tags
}

moved {
  from = random_password.this
  to   = module.server.random_password.this
}

moved {
  from = azurerm_mssql_server.this
  to   = module.server.azurerm_mssql_server.this
}

moved {
  from = azurerm_mssql_firewall_rule.this
  to   = module.server.azurerm_mssql_firewall_rule.this
}

moved {
  from = azurerm_mssql_server_extended_auditing_policy.this
  to   = module.server.azurerm_mssql_server_extended_auditing_policy.this
}

moved {
  from = azurerm_mssql_server_security_alert_policy.this
  to   = module.server.azurerm_mssql_server_security_alert_policy.this
}

moved {
  from = azurerm_storage_account.this
  to   = module.server.azurerm_storage_account.this
}

moved {
  from = azurerm_storage_container.this
  to   = module.server.azurerm_storage_container.this
}

moved {
  from = azurerm_mssql_server_vulnerability_assessment.this
  to   = module.server.azurerm_mssql_server_vulnerability_assessment.this
}

module "database" {
  source = "./modules/database"

  name                 = var.database_name
  server_id            = module.server.id
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

resource "azurerm_mssql_failover_group" "this" {
  for_each = var.failover_groups

  name      = each.value["name"]
  server_id = azurerm_mssql_server.this.id

  databases = [
    module.database.id # TODO: add additional databases?
  ]

  partner_server {
    id = each.value["partner_server_id"]
  }

  read_write_endpoint_failover_policy {
    mode          = each.value["read_write_endpoint_failover_policy_mode"]
    grace_minutes = each.value["read_write_endpoint_failover_policy_grace_minutes"]
  }

  # TODO: add tags?
}
