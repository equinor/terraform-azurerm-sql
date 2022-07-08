variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "database_name" {
  description = "A custom name for this SQL database."
  type        = string
  default     = null
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

variable "storage_account_type" {
  description = "(Optional) Specifies the storage account type used to store backups for this database. Possible values are `Geo`, `GeoZone`, `Local` and `Zone`."
  type        = string
  default     = "Geo"
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "pitr_retention_days" {
  description = "The number of days that point-in-time restore backups should be retained."
  type        = number
  default     = 7
}

variable "ltr_weekly_retention" {
  description = "The duration that weekly long-term backups should be retained in an ISO 8601 duration format."
  type        = string
  default     = "P4W"
}

variable "ltr_monthly_retention" {
  description = "The duration that monthly long-term backups should be retained in an ISO 8601 duration format."
  type        = string
  default     = "PT0S"
}

variable "ltr_yearly_retention" {
  description = "The duration that yearly long-term backups should be retained in an ISO 8601 duration format."
  type        = string
  default     = "PT0S"
}

variable "ltr_week_of_year" {
  description = "The week of year to take the yearly long-term backup."
  type        = number
  default     = 1
}
