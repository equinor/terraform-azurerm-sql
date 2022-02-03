output "sql_server_id" {
  value = azurerm_mssql_server.this.id
}

output "sql_server_admin_login" {
  value     = azurerm_mssql_server.this.administrator_login
  sensitive = true
}

output "sql_server_admin_login_password" {
  value     = azurerm_mssql_server.this.administrator_login_password
  sensitive = true
}
