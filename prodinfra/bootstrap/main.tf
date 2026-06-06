provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state_rg" {
  name     = "terraform-state-rg"
  location = "East US"
}

resource "azurerm_storage_account" "state_sa" {
  name                     = "tfstateproinfra01"
  resource_group_name      = azurerm_resource_group.state_rg.name
  location                 = azurerm_resource_group.state_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    ManagedBy = "Terraform"
    Purpose   = "RemoteStateStorage"
  }
}

resource "azurerm_storage_container" "state_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.state_sa.name
  container_access_type = "private"
}
