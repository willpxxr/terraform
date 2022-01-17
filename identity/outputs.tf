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

output "argocd_sso_roles" {
  value = [for role in local.roles: {
    id = role.id
    name = role.name
  }]
}

output "external_dns_service_account_id" {
  value = module.external_dns_service_account.client_id
}

output "external_dns_service_account_client_secret" {
  value = module.external_dns_service_account.client_secret
  sensitive = true
}
