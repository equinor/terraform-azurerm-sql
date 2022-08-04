provider "azurerm" {
  features {}
}

locals {
  application = random_id.this.hex
  environment = "test"
}

data "azurerm_client_config" "current" {}

data "http" "public_ip" {
  url = "https://ifconfig.me"
}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.application}-${local.environment}"
  location = var.location
}

module "sql" {
  source = "../.."

  application = local.application
  environment = local.environment

  storage_account_name = "st${local.application}sql001"

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  azuread_admin = {
    user_principal_name = "john.smith@example.com"
    object_id           = data.azurerm_client_config.current.object_id
  }

  firewall_rules = {
    "AllowClientPublicIp" = [data.http.public_ip.body, data.http.public_ip.body]
  }
}

module "database" {
  source = "../../modules/database"

  application = local.application
  environment = local.environment
  server_id   = module.sql.server_id
}
