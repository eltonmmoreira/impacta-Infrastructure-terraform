terraform {
  required_version = "~>0.15.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.46.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}