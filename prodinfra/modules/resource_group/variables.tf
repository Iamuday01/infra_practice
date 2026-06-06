variable "name" {
  description = "The name of the resource group"
  type        = string
  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 90 && can(regex("^[a-zA-Z0-9-._()]+$", var.name))
    error_message = "The resource group name must be between 1 and 90 characters and can only contain alphanumeric characters, hyphens, underscores, parentheses, and periods."
  }
}

variable "location" {
  description = "The Azure region where the resource group should be created"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
