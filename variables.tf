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

variable "admin_login" {
  description = "The login username of the administrator of this SQL server."
  type        = string
}

variable "azuread_admin_login" {
  description = "The user principal name or group name of the Azure AD administrator of this SQL server."
  type        = string
}

variable "azuread_admin_object_id" {
  description = "The object ID of the Azure AD administrator of this SQL server."
  type        = string
}

variable "azuread_authentication_only" {
  description = "Should Azure AD-only authentication be enabled?"
  type        = bool
  default     = false
}

variable "identity" {
  description = "The identity to configure for this SQL Server."

  type = object({
    type = optional(string, "SystemAssigned")
    identity_ids  = optional(list(string), [])
  })

  default = null
}

variable "firewall_rules" {
  description = "A map of identifier => SQL server firewall rule."

  type = map(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))

  default = {}
}

variable "firewall_azure_ips_allowed" {
  description = "Should Azure IPs be allowed to bypass this SQL server firewall?"
  type        = bool
  default     = false
}

variable "storage_container_name" {
  description = "The name of this Storage Container."
  type        = string
  default     = "vulnerability-assessment"
}

variable "databases" {
  description = "A map of identifier => SQL Database object."

  type = map(object({
    name                  = string
    sku_name              = optional(string)
    pitr_retention_days   = optional(number)
    ltr_weekly_retention  = optional(string)
    ltr_monthly_retention = optional(string)
    ltr_yearly_retention  = optional(string)
    ltr_week_of_year      = optional(number)
    str_backup_interval   = optional(number)
  }))

  default = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
