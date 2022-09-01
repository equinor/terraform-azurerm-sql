variable "server_name" {
  description = "The name of this SQL server."
  type        = string
}

variable "location" {
  description = "The supported Azure location where the resources exist."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
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

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
