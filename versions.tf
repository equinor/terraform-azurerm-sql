terraform {
  required_version = ">= 1.1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.94.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}
