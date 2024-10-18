variable "server_name" {
  description = "The name of this SQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage account to use for SQL vulnerability assessment."
  type        = string
}

variable "storage_blob_endpoint" {
  description = "The blob endpoint of the Storage account to use for SQL vulnerability assessment."
  type        = string
  nullable    = true
  default     = null
}

variable "storage_container_name" {
  description = "The name of the Storage container to use for SQL vulnerability assessment."
  type        = string
  default     = "vulnerability-assessment"
}

variable "azuread_administrator_login_username" {
  description = "The login username of the Microsoft Entra administrator for this SQL server."
  type        = string
  nullable    = false
}

variable "azuread_administrator_object_id" {
  description = "The object ID of the Microsoft Entra administrator for this SQL server."
  type        = string
  nullable    = false
}

variable "azuread_authentication_only" {
  description = "Should Microsoft Entra authentication only be enabled for this SQL server?"
  type        = bool
  default     = true
}

variable "administrator_login" {
  description = "The login username of the administrator for this SQL server."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "A list of user-assigned identity IDs to be assigned to this SQL server."
  type        = list(string)
  default     = []
}

variable "firewall_rules" {
  description = "A map of firewall rules to be configured for this SQL server."

  type = map(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))

  default = {}
}

variable "firewall_rules_allow_azure_services" {
  description = "Should Azure services be allowed to bypass the firewall rules for this SQL server?"
  type        = bool
  default     = true
  nullable    = false
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["SQLSecurityAuditEvents"]

  # This diagnostic setting is created at the master database scope.
  # The master database represents the server, thus not all database log categories are supported.
  validation {
    condition     = alltrue([for category in var.diagnostic_setting_enabled_log_categories : contains(["SQLSecurityAuditEvents", "DevOpsOperationsAudit"], category)])
    error_message = "Supported log categories are \"SQLSecurityAuditEvents\" and \"DevOpsOperationsAudit\"."
  }
}

variable "security_alert_policy_email_account_admins" {
  description = "Should security alerts for this SQL server be sent to subscription owners?"
  type        = bool
  default     = false
}

variable "security_alert_policy_email_addresses" {
  description = "A list of email addresses to send security alerts for this SQL server to."
  type        = list(string)
  default     = []
}

variable "vulnerability_assessment_recurring_scans_enabled" {
  description = "Should SQL vulnerability assessment recurring scans be enabled?"
  type        = bool
  default     = true
}

variable "vulnerability_assessment_recurring_scans_email_subscription_admins" {
  description = "Should notifications for SQL vulnerability assessment recurring scans be sent to subscription owners?"
  type        = bool
  default     = true
}

variable "vulnerability_assessment_recurring_scans_emails" {
  description = "A list of email addresses to send notifications for SQL vulnerability assessment recurring scans to."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
