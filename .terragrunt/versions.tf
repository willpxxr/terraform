terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.41.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
