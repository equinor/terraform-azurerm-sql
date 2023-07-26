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
  description = "The ID of the Storage account to use for this SQL server."
  type        = string
}

variable "storage_blob_endpoint" {
  description = "The blob endpoint of the Storage account to use for this SQL server."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the Storage container to use for this SQL server."
  type        = string
  default     = "vulnerability-assessment"
}

variable "azuread_administrator_login_username" {
  description = "The login username of the Azure AD administrator for this SQL server."
  type        = string
}

variable "azuread_administrator_object_id" {
  description = "The object ID of the Azure AD administrator for this SQL server."
  type        = string
}

variable "azuread_authentication_only" {
  description = "Should Azure AD authentication only be enabled for this SQL server?"
  type        = bool
  default     = true
}

variable "administrator_login" {
  description = "The login username of the administrator of this SQL server."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "A list of user-assigned identity IDs to be assigned to this SQL server."
  type        = list(string)
  default     = []
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

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["SQLSecurityAuditEvents"]
}

variable "security_alert_policy_email_account_admins" {
  description = "Are alerts for this SQL server sent to subscription owners and administrators?"
  type        = bool
  default     = true
}

variable "security_alert_policy_email_addresses" {
  description = "A list of custom email addresses to which the alert for this SQL server is sent."
  type        = list(string)
  default     = []
}

variable "vulnerability_assessment_recurring_scans_enabled" {
  description = "Specifies if recurring scans is enabled or disabled."
  type        = bool
  default     = true
}

variable "vulnerability_assessment_recurring_scans_email_subscription_admins" {
  description = "Specifies if the schedule scan notification will be sent to the subscriptions administrators for this SQL server."
  type        = bool
  default     = true
}

variable "vulnerability_assessment_recurring_scans_emails" {
  description = "Specifies an array of email addresses to which the scan notification."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
