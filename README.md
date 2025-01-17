# Azure SQL Terraform Module

[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-sql/badge)](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-sql/badge)
[![Equinor Terraform Baseline](https://img.shields.io/badge/Equinor%20Terraform%20Baseline-1.0.0-blueviolet)](https://github.com/equinor/terraform-baseline)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

Terraform module which creates Azure SQL resources.

## Features

- Microsoft Entra administrator enforced.
- Microsoft Entra-only authentication enabled by default.
- Audit logs sent to given Log Analytics workspace by default.
- Vulnerability assessments stored in given Storage account.

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Role Based Access Control Administrator` at the Storage account scope.

## Usage

1. Login to Azure:

    ```console
    az login
    ```

1. Create a Terraform configuration file `main.tf` and add the following example configuration:

    ```terraform
    provider "azurerm" {
      storage_use_azuread = true

      features {}
    }

    resource "azurerm_resource_group" "example" {
      name     = "example-resources"
      location = "westeurope"
    }

    module "log_analytics" {
      source  = "equinor/log-analytics/azurerm"
      version = "~> 11.1"

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

    module "sql" {
      source  = "equinor/storage/azurerm"
      version = "~> 11.0"

      server_name                = "example-sql"
      resource_group_name        = azurerm_resource_group.example.name
      location                   = azurerm_resource_group.example.location
      log_analytics_workspace_id = module.log_analytics.workspace_id
      storage_account_id         = module.storage.account_id

      azuread_administrator_login_username = "EntraAdmin"
      azuread_administrator_object_id      = "8954d564-505c-4cf8-a254-69e3b0facff2"
    }

    module "database" {
      source  = "equinor/storage/azurerm//modules/database"
      version = "~> 11.0"

      database_name              = "example-sqldb"
      server_id                  = module.sql.server_id
      log_analytics_workspace_id = module.log_analytics.workspace_id
    }
    ```

1. Install required provider plugins and modules:

    ```console
    terraform init
    ```

1. Apply the Terraform configuration:

    ```console
    terraform apply
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

## Development

1. Read [this document](https://code.visualstudio.com/docs/devcontainers/containers).

1. Clone this repository.

1. Configure Terraform variables in a file `.devcontainer/devcontainer.env`:

    ```env
    TF_VAR_resource_group_name=
    TF_VAR_location=
    ```

1. Open repository in dev container.

## Testing

1. Change to the test directory:

    ```console
    cd test
    ```

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Run tests:

    ```console
    go test -timeout 60m
    ```

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
