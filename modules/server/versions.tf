terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 2.2.0"
    }
  }
}
