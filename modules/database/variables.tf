variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "server_id" {
  description = "The ID of the SQL server to create this SQL database in."
  type        = string
}

variable "sku_name" {
  description = "The SKU name of this SQL database."
  type        = string
  default     = "Basic"
}

variable "zone_redundancy" {
  description = "Whether or not this database is zone redundant."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
