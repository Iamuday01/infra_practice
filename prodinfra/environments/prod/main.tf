module "resource_group" {
  source = "../../modules/resource_group"

  name     = "${local.resource_name_prefix}-rg"
  location = local.location
  tags     = local.common_tags
}

module "vnet" {
  source = "../../modules/vnet"

  name                = "${local.resource_name_prefix}-vnet"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  address_space       = ["10.0.0.0/16"]
  tags                = local.common_tags
}

module "aks_subnet" {
  source = "../../modules/subnet"

  name                 = "aks-subnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "aks_cluster" {
  source = "../../modules/aks"

  name                = "${local.resource_name_prefix}-aks"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  dns_prefix          = "${local.resource_name_prefix}-aks"
  tags                = local.common_tags

  default_node_pool = {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = module.aks_subnet.id
  }


  depends_on = [module.vnet] # Example of explicit depends_on, though implicit is better
}

module "acr" {
  source = "../../modules/acr"

  name                = replace("${local.resource_name_prefix}acr", "-", "") # ACR name must be alphanumeric
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = "Standard"
  tags                = local.common_tags
}

module "storage" {
  source = "../../modules/storage_account"

  name                     = replace("${local.resource_name_prefix}sa", "-", "")
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags

  network_rules = {
    default_action = "Allow"
  }
}

data "azurerm_client_config" "current" {}

module "key_vault" {
  source = "../../modules/key_vault"

  name                = "${local.resource_name_prefix}-kv"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  tags                = local.common_tags

  access_policies = [
    {
      object_id               = data.azurerm_client_config.current.object_id
      secret_permissions      = ["Get", "List", "Set", "Delete"]
      key_permissions         = ["Get", "List", "Create", "Delete"]
      certificate_permissions = ["Get", "List", "Create", "Delete"]
    }
  ]
}
