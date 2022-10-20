# Azure SQL Terraform module

Terraform module which creates Azure SQL resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_database"></a> [database](#module\_database) | ./modules/database | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [azurerm_mssql_server_security_alert_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy) | resource |
| [azurerm_mssql_server_vulnerability_assessment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_vulnerability_assessment) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_login"></a> [admin\_login](#input\_admin\_login) | The login username of the administrator of this SQL server. | `string` | n/a | yes |
| <a name="input_azuread_admin_login"></a> [azuread\_admin\_login](#input\_azuread\_admin\_login) | The user principal name or group name of the Azure AD administrator of this SQL server. | `string` | n/a | yes |
| <a name="input_azuread_admin_object_id"></a> [azuread\_admin\_object\_id](#input\_azuread\_admin\_object\_id) | The object ID of the Azure AD administrator of this SQL server. | `string` | n/a | yes |
| <a name="input_azuread_authentication_only"></a> [azuread\_authentication\_only](#input\_azuread\_authentication\_only) | Should Azure AD-only authentication be enabled? | `bool` | `false` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | A map of identifier => SQL Database object. | <pre>map(object({<br>    name                  = string<br>    sku_name              = optional(string)<br>    pitr_retention_days   = optional(number)<br>    ltr_weekly_retention  = optional(string)<br>    ltr_monthly_retention = optional(string)<br>    ltr_yearly_retention  = optional(string)<br>    ltr_week_of_year      = optional(number)<br>  }))</pre> | `{}` | no |
| <a name="input_firewall_azure_ips_allowed"></a> [firewall\_azure\_ips\_allowed](#input\_firewall\_azure\_ips\_allowed) | Should Azure IPs be allowed to bypass this SQL server firewall? | `bool` | `false` | no |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | A map of identifier => SQL server firewall rule. | <pre>map(object({<br>    name             = string<br>    start_ip_address = string<br>    end_ip_address   = string<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location to create the resources in. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to create the resources in. | `string` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | The name of this SQL server. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of this Storage account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_login"></a> [admin\_login](#output\_admin\_login) | The login username of the administrator of this SQL server. |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The login password of the administrator of this SQL server. |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | The connection string of this SQL database. |
| <a name="output_database_ids"></a> [database\_ids](#output\_database\_ids) | A mapping of database IDs for this SQL Server |
| <a name="output_server_id"></a> [server\_id](#output\_server\_id) | The ID of this SQL Server. |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name) | The name of this SQL Server. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of this Storage Account. |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of this Storage Account. |
<!-- END_TF_DOCS -->