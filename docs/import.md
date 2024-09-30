# Import

This document contains instructions for [importing existing resources](https://developer.hashicorp.com/terraform/cli/import) to be managed by this module.

## SQL server

The system-assigned identity **must** be enabled for the existing SQL server before importing. This is required for this module to configure Microsoft Entra authentication from the SQL server to the given Storage account.

Enable the system-assigned identity for the existing SQL server by running the following Azure CLI command:

```console
az sql server update -n <SERVER_NAME> -g <RESOURCE_GROUP_NAME> --identity-type SystemAssigned
```
