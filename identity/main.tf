module "atlantis" {
  source = "../modules/azure/service_account"

  application = "Atlantis"
}

module "argocd_sso" {
  source = "../modules/azure/sso"

  application = "ArgoCD"
  redirect_uri = "https://localhost:8080/auth/callback"
  roles = local.roles
}
