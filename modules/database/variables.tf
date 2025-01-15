variable "database_name" {
  description = "The name of this SQL database."
  type        = string
}

variable "server_id" {
  description = "The ID of the server to create this SQL database on."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "elastic_pool_id" {
  description = "The ID of an elastic pool to create this SQL database in."
  type        = string
  default     = null
}

variable "collation" {
  description = "Specificies a collation for this SQL database."
  type        = string
  default     = null
}

variable "enclave_type" {
  description = "Specifies a type of enclave to be used for this SQL database."
  type        = string
  default     = null
}

variable "maintenance_configuration_name" {
  description = "The name of the Public Maintenance Configuration window to apply to this SQL database."
  type        = string
  default     = "SQL_Default"
}

variable "ledger_enabled" {
  description = "Should ledger be enabled for this SQL database?"
  type        = bool
  default     = false
}

variable "max_size_gb" {
  description = "Sets a maximum possible size for this SQL database."
  type        = number
  default     = null
}

variable "sku_name" {
  description = "The name of the SKU to use for this SQL database. Possible values include \"Basic\" (Basic service tier), \"S1\" (Standard service tier, 10 DTUs), \"GP_Gen5_2\" (General Purpose service tier, provisioned compute tier, 2 vCores) and \"GP_S_Gen5_1\" (General Purpose service tier, serverless compute tier, max 1 vCore)."
  type        = string
  default     = "Basic"
}

variable "storage_account_type" {
  description = "The type of Storage account to use for storing backups for this SQL database."
  type        = string
  default     = "Geo"
}

variable "short_term_retention_policy_retention_days" {
  description = "The number of days that short-term retention backups should be retained. Value must be between 7 and 35."
  type        = number
  default     = 7
}

variable "short_term_retention_policy_backup_interval_in_hours" {
  description = "The interval in hours between each short-term retention backup. Value must be 12 or 24."
  type        = number
  default     = 12
}

variable "long_term_retention_policy_weekly_retention" {
  description = "The duration that weekly long-term retention backups should be retained. Value must be in ISO 8601 duration format, e.g. \"P1Y\", \"P1M\", \"P1W\" or \"P7D\"."
  type        = string
  default     = "PT0S"
}

variable "long_term_retention_policy_monthly_retention" {
  description = "The duration that monthly long-term retention backups should be retained. Value must be in ISO 8601 duration format, e.g. \"P1Y\", \"P1M\", \"P4W\" or \"P30D\"."
  type        = string
  default     = "PT0S"
}

variable "long_term_retention_policy_yearly_retention" {
  description = "The duration that yearly long-term retention backups should be retained. Value must be in ISO 8601 duration format, e.g. \"P1Y\", \"P12M\", \"P52W\" or \"P365D\"."
  type        = string
  default     = "PT0S"
}

variable "long_term_retention_policy_week_of_year" {
  description = "The week of year to take the yearly long-term retention backup. Value must be between 1 and 52."
  type        = number
  default     = 1
}

variable "identity_ids" {
  description = "A list of user assigned identities to be assigned to this SQL database."
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
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "min_capacity" {
  description = "Minimal capacity that this SQL database will always have allocated if not paused. Value must be greater than 0 if using a SKU in the serverless compute tier."
  type        = number
  default     = 0
}

variable "auto_pause_delay_in_minutes" {
  description = "Time in minutes after which this SQL database is automatically paused. Value must be greater than 0 if using a SKU in the serverless compute tier."
  type        = number
  default     = 0
}
