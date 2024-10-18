locals {
  storage_account_name  = provider::azurerm::parse_resource_id(var.storage_account_id).resource_name
  storage_blob_endpoint = "https://${local.storage_account_name}.blob.core.windows.net/"

  firewall_rules = var.firewall_rules_allow_azure_services ? {
    # Allow connections from inside Azure.
    # Ref: https://github.com/MicrosoftDocs/sql-docs/blob/2921bf7c9d2301d818479eae0488285403f48250/azure-sql/database/firewall-configure.md#connections-from-inside-azure
    "azure" = {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  } : {}
}
