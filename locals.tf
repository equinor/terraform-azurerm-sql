locals {
  storage_account_name  = provider::azurerm::parse_resource_id(var.storage_account_id).resource_name
  storage_blob_endpoint = "https://${local.storage_account_name}.blob.core.windows.net/"
}
