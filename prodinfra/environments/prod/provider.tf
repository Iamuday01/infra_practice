terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstateproinfra01"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    subscription_id      = "3b770c7c-3dd0-4873-ab89-7c5f4695e464"
  }
}

provider "azurerm" {
  features {}
}
