output "server_id" {
  description = "The ID of this SQL server."
  value       = azurerm_mssql_server.this.id
}

output "server_name" {
  description = "The name of this SQL server."
  value       = azurerm_mssql_server.this.name
}

output "server_fqdn" {
  description = "The fully qualified domain name (FQDN) of this SQL server."
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "administrator_login" {
  description = "The login username of the administrator for this SQL server."
  value       = azurerm_mssql_server.this.administrator_login
}

output "administrator_password" {
  description = "The login password of the administrator for this SQL server."
  value       = azurerm_mssql_server.this.administrator_login_password
  sensitive   = true
}

output "server_security_alert_policy_id" {
  description = "The ID of the security alert policy for this SQL server."
  value       = azurerm_mssql_server_security_alert_policy.this.id
}

output "server_vulnerability_assessment_id" {
  description = "The ID of the vulnerability assessment for this SQL server."
  value       = azurerm_mssql_server_vulnerability_assessment.this.id
}
