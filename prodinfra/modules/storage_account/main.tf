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

  network_rules {
    default_action             = var.network_rules != null ? var.network_rules.default_action : "Deny"
    ip_rules                   = var.network_rules != null ? var.network_rules.ip_rules : []
    virtual_network_subnet_ids = var.network_rules != null ? var.network_rules.virtual_network_subnet_ids : []
    bypass                     = var.network_rules != null ? var.network_rules.bypass : ["AzureServices"]
  }

  lifecycle {
    ignore_changes = [
      tags["CreatedBy"]
    ]
  }
}
