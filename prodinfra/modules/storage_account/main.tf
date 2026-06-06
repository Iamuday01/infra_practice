resource "azurerm_storage_account" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  https_traffic_only_enabled    = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = var.network_rules != null ? true : false # Allow if rules are defined, else secure by default
  tags                          = var.tags

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      default_action             = network_rules.value.default_action
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
      bypass                     = network_rules.value.bypass
    }
  }

  lifecycle {
    ignore_changes = [
      tags["CreatedBy"]
    ]
  }
}
