terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.47.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">=1.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.19.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}
