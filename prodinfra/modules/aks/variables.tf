variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.33"
}

variable "default_node_pool" {
  type = object({
    name           = string
    node_count     = number
    vm_size        = string
    vnet_subnet_id = optional(string)
  })
}

variable "identity_type" {
  type    = string
  default = "SystemAssigned"
}

variable "tags" {
  type    = map(string)
  default = {}
}
