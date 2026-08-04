terraform {
  required_version = ">= 1.8.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # Version 5.0.0 is required to use the "blob_storage_endpoint" argument for the "azurerm_mssql_server_extended_auditing_policy" resource.
      version = ">= 5.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 2.2.0"
    }
  }
}
