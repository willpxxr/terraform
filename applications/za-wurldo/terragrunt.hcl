include {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependency "identity" {
  config_path = "../../identity"
}

inputs = merge(
  local.common_vars.inputs,
  {
    argocd_sso_client_secret = dependency.identity.outputs.argocd_sso_client_secret
    argocd_sso_client_id = dependency.identity.outputs.argocd_sso_client_id
    argocd_sso_tenant_id = dependency.identity.outputs.argocd_sso_tenant_id
    argocd_sso_roles = dependency.identity.outputs.argocd_sso_roles
  }
)
