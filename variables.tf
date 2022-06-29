variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "storage_account_name" {
  description = "A custom name for the Storage Account."
  type        = string
  default     = null
}

variable "location" {
  description = "The supported Azure location where the resources exist."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "server_name" {
  description = "A custom name for this SQL server."
  type        = string
  default     = null
}

variable "azuread_admin_login" {
  description = "The login username of the Azure AD administrator of this SQL server."
  type        = string
}

variable "azuread_admin_object_id" {
  description = "The object ID of the Azure AD administrator of this SQL server."
  type        = string
}

variable "firewall_rules" {
  description = "A map of IP address ranges that should be able to access this SQL Server."
  type        = map(tuple([string, string]))
}

variable "threat_protection_enabled" {
  description = "Is threat protection (Microsoft Defender for Storage) enabled for this Storage Account?"
  type        = bool
  default     = true
}
