# Azure SQL Terraform Module

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Equinor Terraform Baseline](https://img.shields.io/badge/Equinor%20Terraform%20Baseline-1.0.0-blueviolet)](https://github.com/equinor/terraform-baseline)

Terraform module which creates Azure SQL resources:

- Creates an Azure SQL server in the provided resource group.
- Stores vulnerability assessments in the provided Storage account.

## Usage

See [examples](examples).

## Development

1. Clone this repository:

    ```console
    git clone https://github.com/equinor/terraform-azurerm-sql.git
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

## Contributing

See [Contributing guidelines](CONTRIBUTING.md).
