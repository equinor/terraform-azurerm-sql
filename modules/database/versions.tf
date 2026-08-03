terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # Version 5.0.0 is required to use the "threat_detection_policy.email_account_admins_enabled" argument for the "azurerm_mssql_database" resource.
      version = ">= 5.0.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = ">= 2.0.0"
    }
  }
}
