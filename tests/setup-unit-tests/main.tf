terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

resource "random_id" "name_suffix" {
  byte_length = 8
}

resource "random_uuid" "subscription_id" {}
resource "random_uuid" "azuread_administrator_object_id" {}
locals {
  name_suffix                     = random_id.name_suffix.hex
  subscription_id                 = random_uuid.subscription_id.result
  resource_group_name             = "rg-${local.name_suffix}"
  server_name                     = "sql-${local.name_suffix}"
  log_analytics_workspace_name    = "log-${local.name_suffix}"
  azuread_administrator_object_id = random_uuid.azuread_administrator_object_id.result

}
