variable "name" {
  type        = string
  description = "Name of the VNet"
}

variable "resource_group_name" {
  type        = string
  description = "RG name"
}

variable "location" {
  type        = string
  description = "Region"
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space"
  default     = ["10.0.0.0/16"]
}

variable "tags" {
  type    = map(string)
  default = {}
}
