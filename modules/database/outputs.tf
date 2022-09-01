output "id" {
  description = "The ID of this SQL database."
  value       = azurerm_mssql_database.this.id
}

output "name" {
  description = "The name of this SQL database."
  value       = azurerm_mssql_database.this.name
}
