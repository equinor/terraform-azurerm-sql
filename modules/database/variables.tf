variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
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

variable "zone_redundancy" {
  description = "Whether or not this database is zone redundant."
  type        = bool
  default     = true
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

variable "ltr_weekly_duration" {
  description = "The duration to keep weekly backups for in an ISO 8601 duration format."
  type        = string
  default     = "P4W"
}

variable "ltr_monthly_duration" {
  description = "The duration to keep the first backup of each month for in an ISO 8601 duration format."
  type        = string
  default     = "PT0S"
}

variable "ltr_yearly_duration" {
  description = "The duration to keep the yearly backup for in an ISO 8601 duration format."
  type        = string
  default     = "PT0S"
}

variable "ltr_week_of_year" {
  description = "The week of year to take the yearly backup."
  type        = number
  default     = 1
}
