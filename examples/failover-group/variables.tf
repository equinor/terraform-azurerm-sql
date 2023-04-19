variable "location" {
  description = "The location to create the resources in."
  type        = string
  default     = "northeurope"
}

variable "location_secondary" {
  description = "The secondary location to create the resources in."
  type        = string
  default     = "westeurope"
}
