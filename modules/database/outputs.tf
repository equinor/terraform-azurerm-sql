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

output "connection_strings" {
  description = "The connection strings of the SQL Database"
  value       = "Server=tcp:${azurerm_mssql_server.this.name}.database.windows.net,1433;Initial Catalog=${azurerm_mssql_databse.this.name};Persist Security Info=False;User ID=${azurerm_mssql_server.this.administrator_login};Password=${azurerm_mssql_server.this.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensetive   = true
}
