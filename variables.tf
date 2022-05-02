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

variable "sql_server_name" {
  description = "A custom name for the SQL Server."
  type        = string
  default     = null
}

variable "azuread_admin_name" {
  description = "The name of the Azure AD admin for the SQL Server."
  type        = string
}

variable "azuread_admin_object_id" {
  description = "The object ID of the Azure AD admin for the SQL Server."
  type        = string
}

variable "firewall_allow_azure_ips" {
  description = "Allow Azure IPs to bypass the firewall and access the SQL Server."
  type        = bool
  default     = true
}
