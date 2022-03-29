terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.94.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
