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

variable "azuread_admin" {
  description = "The user principal name (or group name) and object ID of the Azure AD administrator of this SQL server."
  type = object({
    user_principal_name = string
    object_id           = string
  })
  default = null
}

variable "firewall_rules" {
  description = "A map of IP address ranges that should be able to access this SQL Server."
  type        = map(tuple([string, string]))
}

variable "databases" {
  description = "A mapping of databases to create for this SQL Server."
  type = map(object({
    name                  = string
    sku_name              = optional(string, "Basic")
    pitr_retention_days   = optional(number, 7)
    ltr_weekly_retention  = optional(string, "PT0S")
    ltr_monthly_retention = optional(string, "PT0S")
    ltr_yearly_retention  = optional(string, "PT0S")
    ltr_week_of_year      = optional(number, 1)
  }))
  default = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
