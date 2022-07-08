output "database_id" {
  description = "The ID of this SQL database."
  value       = azurerm_mssql_database.this.id
}

output "database_name" {
  description = "The name of this SQL database."
  value       = azurerm_mssql_database.this.name
}
