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

## Development

1. Clone this repository:

    ```console
    git clone https://github.com/equinor/terraform-azurerm-sql.git
    ```

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Set environment variables:

    ```console
    export TF_VAR_resource_group_name=<RESOURCE_GROUP_NAME>
    export TF_VAR_location=<LOCATION>
    export ARM_SKIP_PROVIDER_REGISTRATION=true
    ```

## Testing

1. Initialize working directory:

    ```console
    terraform init
    ```

1. Execute tests:

    ```console
    terraform test
    ```

    See [`terraform test` command documentation](https://developer.hashicorp.com/terraform/cli/commands/test) for options.

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
