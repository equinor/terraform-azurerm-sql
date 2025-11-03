terraform {
  required_version = ">= 1.8.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # Exluding Azure provider version v4.31 due to a breaking change making optional arguments, only working in certain scenarios, required.
      # Will keep this version excluded until fix is availiable. Ref.: https://github.com/hashicorp/terraform-provider-azurerm/pull/29789
      version = ">= 4.0.0, != 4.31.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 2.2.0"
    }
  }
}
