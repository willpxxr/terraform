module "managed_kubernetes" {
  source = "../../modules/azure/managed_kubernetes"

  name = "za-wurldo"
  zone = "UK South"
}

module "argocd" {
  source = "../../modules/common/argocd"

  kubernetes_host = module.managed_kubernetes.host
  client_certificate = module.managed_kubernetes.client_certificate
  client_key = module.managed_kubernetes.client_key
  cluster_ca_certificate = module.managed_kubernetes.ca_cert
  argocd_sso_client_id = var.argocd_sso_client_id
  argocd_sso_tenant_id = var.argocd_sso_tenant_id
  argocd_sso_client_secret = var.argocd_sso_client_secret
  argocd_ingress_domain = format("argocd.mgmgt.%s", var.domain)
  argocd_github_access_token = var.github_secret
  argocd_sso_roles = var.argocd_sso_roles
}
