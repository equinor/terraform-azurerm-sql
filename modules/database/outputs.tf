output "database_id" {
  description = "Resource id of the database"
  value       = azurerm_mssql_database.this.id
}

output "database_name" {
  description = "Name of the database"
  value       = azurerm_mssql_database.this.name
}


