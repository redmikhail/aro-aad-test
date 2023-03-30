terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.47.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.7.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">=1.4.0"
    }    
  }
}
