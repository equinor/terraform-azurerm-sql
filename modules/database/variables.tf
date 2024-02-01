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
  default     = "LicenseIncluded"
}

variable "max_size_gb" {
  description = "Sets the maximum possible size of the database"
  type        = number
  default     = null
}

variable "sku_name" {
  description = "Specifies the SKU to use for this database"
  type        = string
  default     = null
}

variable "storage_account_type" {
  description = "Specifies th storage account type used to store backups for this database"
  type        = string
  default     = "Geo"
}

variable "long_term_retention_policy" {
  description = "Sets the long term retention policy rules"
  type = object({
    weekly_retention  = optional(string, "P1M")
    monthly_retention = optional(string, "PT0S")
    yearly_retention  = optional(string, "PT0S")
    week_of_year      = optional(number, 1)
  })
  default = {
    weekly_retention  = "P1M"
    monthly_retention = "PT0S"
    yearly_retention  = "PT0S"
    week_of_year      = "1"
  }
}

variable "threat_detection_policy" {
  description = "Set threat detection policy rules"
  type = object({
    state                      = optional(string, "Disabled")
    disabled_alerts            = optional(list, [])
    email_account_admins       = optional(bool, true)
    email_addresses            = optional(list, [])
    retention_days             = optional(number, null)
    storage_account_access_key = optional(string, null)
    storage_endpoint           = optional(string, null)
  })

  default = {}
}

variable "identities" {
  description = "List of user assigned identities to be configured on this database"
  type        = list(string)
  default     = []
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default = [
    "AutomaticTuning",
    "Blocks",
    "DatabaseWaitStatistics",
    "Deadlocks",
    "DevOpsOperationsAudit",
    "DmsWorkers",
    "Errors",
    "ExecRequests",
    "QueryStoreRuntimeStatistics",
    "QueryStoreWaitStatistics",
    "RequestSteps",
    "SQLInsights",
    "SqlRequests",
    "SQLSecurityAuditEvents",
    "Timeouts",
    "Waits"
  ]
}

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default = [
    "Basic",
    "InstanceAndAppAdvanced",
    "WorkloadManagement"
  ]
}
