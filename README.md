# Azure SQL Terraform module

Terraform module which creates Azure SQL resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |
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
| <a name="input_azuread_admin"></a> [azuread\_admin](#input\_azuread\_admin) | The user principal name (or group name) and object ID of the Azure AD administrator of this SQL server. | <pre>object({<br>    user_principal_name = string<br>    object_id           = string<br>  })</pre> | `null` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of this SQL database. | `string` | n/a | yes |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | A map of IP address ranges that should be able to access this SQL Server. | `map(tuple([string, string]))` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location to create the resources in. | `string` | n/a | yes |
| <a name="input_ltr_monthly_retention"></a> [ltr\_monthly\_retention](#input\_ltr\_monthly\_retention) | The duration that monthly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P1M`, `P4W` or `P30D`. | `string` | `"PT0S"` | no |
| <a name="input_ltr_week_of_year"></a> [ltr\_week\_of\_year](#input\_ltr\_week\_of\_year) | The week of year to take the yearly long-term backup. Value must be between `1` and `52`. | `number` | `1` | no |
| <a name="input_ltr_weekly_retention"></a> [ltr\_weekly\_retention](#input\_ltr\_weekly\_retention) | The duration that weekly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P1M`, `P1W` or `P7D`. | `string` | `"P1M"` | no |
| <a name="input_ltr_yearly_retention"></a> [ltr\_yearly\_retention](#input\_ltr\_yearly\_retention) | The duration that yearly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P12M`, `P52W` or `P365D` | `string` | `"PT0S"` | no |
| <a name="input_pitr_retention_days"></a> [pitr\_retention\_days](#input\_pitr\_retention\_days) | The number of days that point-in-time restore backups should be retained. Value must be between `7` and `35` | `number` | `7` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to create the resources in. | `string` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | The name of this SQL server. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of this SQL database. | `string` | `"Basic"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of this Storage account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_login"></a> [admin\_login](#output\_admin\_login) | The login username of the administrator of this SQL server. |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The login password of the administrator of this SQL server. |
| <a name="output_server_id"></a> [server\_id](#output\_server\_id) | The ID of this SQL Server. |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name) | The name of this SQL Server. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of this Storage Account. |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of this Storage Account. |
<!-- END_TF_DOCS -->