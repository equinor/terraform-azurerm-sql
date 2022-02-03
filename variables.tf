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

variable "sql_server_azuread_admin" {
  description = "Azure AD user or group that should have admin access to the SQL server"
  type = object({
    login_username = string
    object_id      = string
  })
}
