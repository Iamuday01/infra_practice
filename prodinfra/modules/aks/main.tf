resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  tags                = var.tags

  default_node_pool {
    name           = var.default_node_pool.name
    node_count     = var.default_node_pool.node_count
    vm_size        = var.default_node_pool.vm_size
    vnet_subnet_id = var.default_node_pool.vnet_subnet_id
  }

  identity {
    type = var.identity_type
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count # Let cluster autoscaler manage this if enabled
    ]
  }
}
