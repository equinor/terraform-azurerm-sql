output "server_id" {
  description = "The ID of this SQL Server."
  value       = azurerm_mssql_server.this.id
}

output "server_name" {
  description = "The name of this SQL Server."
  value       = azurerm_mssql_server.this.name
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

output "storage_account_id" {
  description = "The ID of this Storage Account."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of this Storage Account."
  value       = azurerm_storage_account.this.name
}

output "database_ids" {
  description = "A mapping of database IDs for this SQL Server"
  value = {
    for k, v in module.database : k => v.id
  }
}

output "connection_strings" {
  description = "A mapping of connection strings for the SQL Server"
  value = {
    for a, b in module.database : a => b.connection_strings
  }
}
