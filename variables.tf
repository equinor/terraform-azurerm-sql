variable "database_name" {
  description = "The name of this SQL database."
  type        = string
}

variable "server_name" {
  description = "The name of this SQL server."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "storage_account_name" {
  description = "The name of this Storage account."
  type        = string
}

variable "administrator_login" {
  description = "The login username of the administrator of this SQL server."
  type        = string
}

variable "azuread_administrator" {
  description = "An Azure AD administrator to configure for this SQL server."

  type = object({
    login_username              = string
    object_id                   = string
    azuread_authentication_only = optional(bool, false)
  })

  default = null
}

variable "identity" {
  description = "The identity to configure for this SQL Server."

  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string), [])
  })

  default = null
}

variable "firewall_rules" {
  description = "A map of firewall rules for this SQL server."

  type = map(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))

  default = {
    "azure" = {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }
}

variable "security_alert_policy_email_addresses" {
  description = "A list of custom email addresses to which the alert for this SQL server is sent."
  type        = list(string)
  default     = []
}

variable "security_alert_policy_email_account_admins" {
  description = "Are alerts for this SQL server sent to subscription owners and administrators?"
  type        = bool
  default     = true
}
variable "storage_container_name" {
  description = "The name of this Storage Container."
  type        = string
  default     = "vulnerability-assessment"
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

variable "database_storage_account_type" {
  description = "The type of Storage account used to store backups for this SQL database."
  type        = string
  default     = "Geo"
}

variable "short_term_retention_policy_retention_days" {
  description = "The number of days that point-in-time restore backups should be retained."
  type        = number
  default     = 7
}

variable "short_term_retention_policy_backup_interval_in_hours" {
  description = "The hours between each differential backup. Value has to be 12 or 24."
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

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "log_analytics_destination_type" {
  description = "The type of log analytics destination to use for this Log Analytics Workspace."
  type        = string
  default     = null
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
    "DevOpsOperationsAudit",
    "SQLSecurityAuditEvents"
  ]
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
