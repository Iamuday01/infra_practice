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

variable "service_cidr" {
  type        = string
  description = "The Network Range used by the Kubernetes service."
  default     = "172.16.0.0/16"
}

variable "dns_service_ip" {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery."
  default     = "172.16.0.10"
}

variable "tags" {
  type    = map(string)
  default = {}
}
