include {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

dependency "identity" {
  config_path = "../../identity"
}

inputs = {
  argocd_sso_client_secret = dependency.identity.outputs.argocd_sso_client_secret
  argocd_sso_client_id = dependency.identity.outputs.argocd_sso_client_id
  argocd_sso_tenant_id = dependency.identity.outputs.argocd_sso_tenant_id
}
