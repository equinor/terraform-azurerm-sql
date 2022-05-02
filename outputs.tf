output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the Storage Account."
  value       = azurerm_storage_account.this.name
}

output "sql_server_id" {
  description = "The ID of the SQL Server."
  value       = azurerm_mssql_server.this.id
}

output "sql_server_name" {
  description = "The name of the SQL Server."
  value       = azurerm_mssql_server.this.name
}

output "sql_server_admin_login" {
  description = "The admin login of the SQL Server."
  value       = azurerm_mssql_server.this.administrator_login
}

output "sql_server_admin_login_password" {
  description = "The admin login password of the SQL Server."
  value       = azurerm_mssql_server.this.administrator_login_password
  sensitive   = true
}
