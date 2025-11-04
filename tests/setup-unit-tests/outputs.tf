output "resource_group_name" {
  value = local.resource_group_name
}

output "location" {
  value = "northeurope"
}

output "administrator_login" {
  value = "azureadminuser"
}

output "log_analytics_workspace_id" {
  value = "/subscriptions/${local.subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${local.log_analytics_workspace_name}"
}

output "azuread_administrator_login_username" {
  value = "azureadadminuser"
}

output "azuread_administrator_object_id" {
  value = local.azuread_administrator_object_id
}

output "subscription_id" {
  value = local.subscription_id
}

output "server_name" {
  value = local.server_name
}
output "log_analytics_workspace_name" {
  value = local.log_analytics_workspace_name
}
