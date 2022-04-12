variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "storage_account_name" {
  description = "Specifies the name of the Storage Account."
  type        = string
  default     = null
}

variable "location" {
  description = "Specifies the supported Azure location where the resources exist."
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
  description = "Specifies the name of the SQL Server."
  type        = string
  default     = null
}

variable "azuread_admin_login_username" {
  description = "The login username of the Azure AD Administrator of the SQL Server."
  type        = string
}

variable "azuread_admin_object_id" {
  description = "The object id of the Azure AD Administrator of the SQL Server."
  type        = string
}

variable "firewall_allow_all_azure_ips" {
  description = "Allow Azure services and resources to access the SQL Server."
  type        = bool
  default     = true
}
