variable "database_name" {
  description = "The name this SQL database."
  type        = string
}

variable "server_id" {
  description = "The ID of the SQL server to create this SQL database in."
  type        = string
}

variable "sku_name" {
  description = "The SKU name of this SQL database."
  type        = string
  default     = "Basic"
}

variable "max_size_gb" {
  description = "The max size of this SQL database in gigabytes."
  type        = number
  default     = null
}

variable "storage_account_type" {
  description = "The type of Storage account used to store backups for this SQL database. Value must be `Geo`, `GeoZone`, `Local` or `Zone`."
  type        = string
  default     = "Geo"
}

variable "short_term_retention_policy_retention_days" {
  description = "The number of days that point-in-time restore backups should be retained. Value must be between `7` and `35`"
  type        = number
  default     = 7
}

variable "short_term_retention_policy_backup_interval_in_hours" {
  description = "The hours between each differential backup. Value has to be 12 or 24, defaults to 12 hours."
  type        = number
  default     = 12
}

variable "long_term_retention_policy_weekly_retention" {
  description = "The duration that weekly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P1M`, `P1W` or `P7D`."
  type        = string
  default     = "PT0S"
}

variable "long_term_retention_policy_monthly_retention" {
  description = "The duration that monthly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P1M`, `P4W` or `P30D`."
  type        = string
  default     = "PT0S"
}

variable "long_term_retention_policy_yearly_retention" {
  description = "The duration that yearly long-term backups should be retained. Value must be in an ISO 8601 duration format, e.g. `P1Y`, `P12M`, `P52W` or `P365D`"
  type        = string
  default     = "PT0S"
}

variable "long_term_retention_policy_week_of_year" {
  description = "The week of year to take the yearly long-term backup. Value must be between `1` and `52`."
  type        = number
  default     = 1
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
