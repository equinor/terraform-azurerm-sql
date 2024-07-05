output "server_name" {
  value = "sql-${local.name_suffix}"
}

output "server_id" {
  value = "/subscriptions/${random_uuid.subscription_id.result}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Sql/servers/${local.server_name}"
}

output "database_name" {
  value = "sqldb-${local.name_suffix}"
}

output "azuread_administrator_login_username" {
  value = local.name_suffix
}

output "azuread_administrator_object_id" {
  value = random_uuid.subscription_id.result
}

output "resource_group_name" {
  value = "rg-${local.name_suffix}"
}

output "location" {
  value = "northeurope"
}

output "log_analytics_workspace_id" {
  value = "/subscriptions/${random_uuid.subscription_id.result}/resourceGroups/${local.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/log-${local.name_suffix}"
}

output "account_name" {
  value = "st${local.name_suffix}"
}

output "storage_account_id" {
  value = "/subscriptions/${random_uuid.subscription_id.result}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Storage/storageAccounts/${local.account_name}"
}

output "storage_blob_endpoint" {
  value = "https://${local.account_name}.blob.core.windows.net/"
}
