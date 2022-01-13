variable "argocd_sso_client_secret" {}

variable "argocd_sso_client_id" {}

variable "argocd_sso_tenant_id" {}

variable "github_secret" {}

variable "domain" {}

variable "argocd_sso_roles" {
  type =  list(
    object({
      id: string
      name: string
    })
  )
}