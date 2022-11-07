output "id" {
  description = "The ID of this SQL database."
  value       = azurerm_mssql_database.this.id
}

output "name" {
  description = "The name of this SQL database."
  value       = azurerm_mssql_database.this.name
}

output "admin_login" {
  description = "The login username of the administrator of this SQL server."
  value       = azurerm_mssql_server.this.administrator_login
}

output "admin_password" {
  description = "The login password of the administrator of this SQL server."
  value       = azurerm_mssql_server.this.administrator_login_password
  sensitive   = true
}
