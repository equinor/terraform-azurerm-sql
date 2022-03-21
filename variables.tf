variable "app_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sql_server_name" {
  description = "SQL server name, generated if not set"
  type        = string
  default     = null
}

variable "sql_server_azuread_admin" {
  description = "Azure AD user or group that should have admin access to the SQL server"
  type = object({
    login_username = string
    object_id      = string
  })
}

variable "sql_server_firewall_allow_azure" {
  description = "Allow Azure services and resources to access this server"
  type        = bool
  default     = true
}
