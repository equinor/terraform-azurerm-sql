variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "server_id" {
  description = "The resource id of the server to create this database in"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "elastic_pool_id" {
  description = "The resource id of the elastic pool for the server"
  type        = string
  default     = null
}

variable "collation" {
  description = "Database collation"
  type        = string
  default     = null
}

variable "enclave_type" {
  description = "Set security enclave type"
  type        = string
  default     = null
}

variable "maintenance_configuration_name" {
  description = "The name of the Public Maintenance Configuration window to apply to the database"
  type        = string
  default     = "SQL_Default"
}

variable "ledger_enabled" {
  description = "Create database as a ledger database. Changing this forces a new resource to be created"
  type        = bool
  default     = false
}

variable "license_type" {
  description = "Specifies the license type for this database"
  type        = string
  default     = null
}

variable "max_size_gb" {
  description = "Sets the maximum possible size of the database"
  type        = number
  default     = null
}

variable "sku_name" {
  description = "Specifies the SKU to use for this database"
  type        = string
  default     = "Basic"
}

variable "storage_account_type" {
  description = "Specifies th storage account type used to store backups for this database"
  type        = string
  default     = "Geo"
}

variable "str_policy_retention_days" {
  description = "The number of days that point-in-time restore backups should be retained. Value must be between `7` and `35`"
  type        = number
  default     = 7
}

variable "str_policy_interval_hours" {
  description = "The hours between each differential backup. Value has to be 12 or 24, defaults to 12 hours."
  type        = number
  default     = 12
}

variable "ltr_policy_weekly_retention" {
  description = "The duration that weekly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P1M`, `P1W` or `P7D`."
  type        = string
  default     = "PT0S"
}

variable "ltr_policy_monthly_retention" {
  description = "The duration that monthly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P1M`, `P4W` or `P30D`."
  type        = string
  default     = "PT0S"
}

variable "ltr_policy_yearly_retention" {
  description = "The duration that yearly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P12M`, `P52W` or `P365D`"
  type        = string
  default     = "PT0S"
}

variable "ltr_policy_week_of_year" {
  description = "The week of year to take the yearly long-term backup. Value must be between `1` and `52`."
  type        = number
  default     = 1
}

variable "identity_ids" {
  description = "List of user assigned identities to be configured on this database"
  type        = list(string)
  default     = []
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "service-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)

  # Enable service logs by default.
  # Ref: https://learn.microsoft.com/en-us/azure/azure-sql/database/metrics-diagnostic-telemetry-logging-streaming-export-configure?view=azuresql&tabs=azure-portal#databases-in-azure-sql-database
  default = [
    "AutomaticTuning",
    "Blocks",
    "DatabaseWaitStatistics",
    "Deadlocks",
    "Errors",
    "QueryStoreRuntimeStatistics",
    "QueryStoreWaitStatistics",
    "SQLInsights",
    "Timeouts"
  ]
}

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of metric categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
