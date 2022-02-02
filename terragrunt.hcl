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

    subscription_id = "a653fcc5-5b9c-4d8e-820d-7cd61fb8c3d8"
    tenant_id = "f96bf61a-8913-4999-9e1d-eff3a996f979"
    client_id = "7e278bb3-6f57-40c4-ad50-04ba578f89bf"
    client_secret = get_env("TF_VAR_client_secret")
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
