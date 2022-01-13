output "argocd_sso_client_secret" {
  value = module.argocd_sso.secret
  sensitive = true
}

output "argocd_sso_client_id" {
  value = module.argocd_sso.client_id
}

output "argocd_sso_tenant_id" {
  value = module.argocd_sso.tenant_id
}
