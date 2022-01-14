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
  }
}

generate "versions" {
  path = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents = file(".terragrunt/versions.tf")
}

generate "providers" {
  path = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = file(".terragrunt/providers.tf")
}

prevent_destroy = true
