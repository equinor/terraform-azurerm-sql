# Terraform module for Azure SQL

Terraform module which creates Azure SQL resources.

## Features

- SQL server created in given resource group.
- Microsoft Entra administrator enforced.
- Microsoft Entra-only authentication enabled by default.
- Audit logs sent to given Log Analytics workspace by default.
- Vulnerability assessment scan express configuration enabled.

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Log Analytics Contributor` at the Log Analytics workspace scope.

## Usage

```terraform
provider "azurerm" {

  features {}
}

module "sql" {
  source  = "equinor/sql/azurerm"
  version = "~> 11.1"

  server_name                = "example-sql"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  azuread_administrator_login_username = "EntraAdmin"
  azuread_administrator_object_id      = "8954d564-505c-4cf8-a254-69e3b0facff2"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "~> 2.0"

  workspace_name      = "example-workspace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

```

## Known Issues

None, at the moment.

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
