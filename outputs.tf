output "server_id" {
  description = "The ID of this SQL Server."
  value       = module.server.id
}

output "server_name" {
  description = "The name of this SQL Server."
  value       = module.server.name
}

output "administrator_login" {
  description = "The login username of the administrator of this SQL server."
  value       = module.server.administrator_login
}

output "administrator_password" {
  description = "The login password of the administrator of this SQL server."
  value       = module.server.administrator_password
  sensitive   = true
}

output "storage_account_id" {
  description = "The ID of this Storage Account."
  value       = module.server.storage_account_id
}

output "storage_account_name" {
  description = "The name of this Storage Account."
  value       = module.server.storage_account_name
}

output "database_id" {
  description = "The ID of this SQL database."
  value       = module.database.id
}
