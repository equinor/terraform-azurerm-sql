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

variable "administrator_login" {
  description = "The login username of the administrator of this SQL server."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "storage_blob_endpoint" {
  description = "The blob endpoint Storage account to use for this SQL server."
  type        = string
}

variable "storage_account_access_key" {
  description = "The shared access key of the Storage account to use for this SQL server."
  type        = string
  sensitive   = true
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

variable "failover_groups" {
  description = "A map of failover groups for this SQL server."

  type = map(object({
    name              = string
    partner_server_id = string
    databases         = list(string)

    readonly_endpoint_failover_policy_enabled         = optional(bool, false)
    read_write_endpoint_failover_policy_mode          = optional(string, "Automatic")
    read_write_endpoint_failover_policy_grace_minutes = optional(number, 60)
  }))

  default = {}
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
