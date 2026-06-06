resource "azurerm_key_vault" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = var.sku_name
  tags                          = var.tags
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false # Set to true for higher security in prod
  public_network_access_enabled = true  # Usually required for dev, restrict in prod

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow" # In prod, this should be "Deny" with specific IP/Subnet rules
  }

  dynamic "access_policy" {
    for_each = var.access_policies
    content {
      tenant_id               = var.tenant_id
      object_id               = access_policy.value.object_id
      secret_permissions      = access_policy.value.secret_permissions
      key_permissions         = access_policy.value.key_permissions
      certificate_permissions = access_policy.value.certificate_permissions
    }
  }
}
