remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "terraform"
    storage_account_name = "willpxxr"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    disable_dependency_optimization = true
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<-EOF
    terraform {
      required_providers {
        azurerm = {
          source = "hashicorp/azurerm"
          version = "2.91.0"
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

    provider azurerm {
      features {}
    }

    provider helm {
    }

    provider random {
    }
    EOF
}

prevent_destroy = true