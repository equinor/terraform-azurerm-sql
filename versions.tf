terraform {
  required_version = ">= 1.8.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # Version 4.26.0 is required to use the "express_vulnerability_assessment_enabled" argument for the "azurerm_mssql_server" resource.
      # Ref: https://github.com/hashicorp/terraform-provider-azurerm/releases/tag/v12.0.1
      version = ">= 4.26.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 2.2.0"
    }
  }
}
