output "server_id" {
  description = "The ID of this SQL Server."
  value       = azurerm_mssql_server.this.id
}

output "server_name" {
  description = "The name of this SQL Server."
  value       = azurerm_mssql_server.this.name
}

output "administrator_login" {
  description = "The login username of the administrator of this SQL server."
  value       = azurerm_mssql_server.this.administrator_login
}

output "administrator_password" {
  description = "The login password of the administrator of this SQL server."
  value       = azurerm_mssql_server.this.administrator_login_password
  sensitive   = true
}

output "storage_account_id" {
  description = "The ID of this Storage Account."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of this Storage Account."
  value       = azurerm_storage_account.this.name
}
