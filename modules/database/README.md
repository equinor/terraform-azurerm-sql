# Azure SQL database Terraform module

Terraform module which creates an Azure SQL database.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | The application to create the resources for. | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | A custom name for this SQL database. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to create the resources for. | `string` | n/a | yes |
| <a name="input_ltr_monthly_retention"></a> [ltr\_monthly\_retention](#input\_ltr\_monthly\_retention) | The duration that monthly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P1M`, `P4W` or `P30D`. | `string` | `"PT0S"` | no |
| <a name="input_ltr_week_of_year"></a> [ltr\_week\_of\_year](#input\_ltr\_week\_of\_year) | The week of year to take the yearly long-term backup. Value must be between `1` and `52`. | `number` | `1` | no |
| <a name="input_ltr_weekly_retention"></a> [ltr\_weekly\_retention](#input\_ltr\_weekly\_retention) | The duration that weekly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P1M`, `P1W` or `P7D`. | `string` | `"P1M"` | no |
| <a name="input_ltr_yearly_retention"></a> [ltr\_yearly\_retention](#input\_ltr\_yearly\_retention) | The duration that yearly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P12M`, `P52W` or `P365D` | `string` | `"PT0S"` | no |
| <a name="input_pitr_retention_days"></a> [pitr\_retention\_days](#input\_pitr\_retention\_days) | The number of days that point-in-time restore backups should be retained. Value must be between `7` and `35` | `number` | `7` | no |
| <a name="input_server_id"></a> [server\_id](#input\_server\_id) | The ID of the SQL server to create this SQL database in. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of this SQL database. | `string` | `"Basic"` | no |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | The type of Storage account used to store backups for this SQL database. Value must be `Geo`, `GeoZone`, `Local` or `Zone`. | `string` | `"Geo"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_id"></a> [database\_id](#output\_database\_id) | The ID of this SQL database. |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | The name of this SQL database. |
<!-- END_TF_DOCS -->