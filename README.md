# Terraform module for Azure SQL

[![GitHub License](https://img.shields.io/github/license/equinor/terraform-azurerm-sql)](https://github.com/equinor/terraform-azurerm-sql/blob/main/LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-sql)](https://github.com/equinor/terraform-azurerm-sql/releases/latest)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-sql/badge)](https://developer.equinor.com/governance/scm-policy/)

Terraform module which creates Azure SQL resources.

## Features

- SQL server created in given resource group.
- Microsoft Entra administrator enforced.
- Microsoft Entra-only authentication enabled by default.
- Audit logs sent to given Log Analytics workspace by default.
- Vulnerability assessment scan results stored in given Storage account.

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Log Analytics Contributor` at the Log Analytics workspace scope.
- Azure role `Role Based Access Control Administrator` at the Storage account scope.

## Usage

```terraform
provider "azurerm" {
  storage_use_azuread = true

  features {}
}

module "sql" {
  source  = "equinor/sql/azurerm"
  version = "~> 11.1"

  server_name                = "example-sql"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
  storage_account_id         = module.storage.account_id

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

module "storage" {
  source  = "equinor/storage/azurerm"
  version = "~> 12.0"

  account_name               = "sqlstorage"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
```

## Known Issues

### Error when importing existing SQL server

When importing an existing SQL server into state, you might encounter the following error:

```plaintext
Error: Missing required argument. The argument "principal_id" is required, but no definition was found.
```

To resolve this issue, the system-assigned identity **must** be enabled for the existing SQL server before importing. This is required for this module to configure Microsoft Entra authentication from the SQL server to the given Storage account.

Enable the system-assigned identity for the existing SQL server by running the following Azure CLI command:

```console
az sql server update -n <SERVER_NAME> -g <RESOURCE_GROUP_NAME> --identity-type SystemAssigned
```

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
