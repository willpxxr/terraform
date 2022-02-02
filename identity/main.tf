#module "atlantis" {
#  source = "../modules/azure/service_account"
#
#  application = "Atlantis"
#}

data "azurerm_client_config" "this" {
}

module "terraform_service_account" {
  source = "../modules/azure/service_account"

  application = "Terraform"
  scope = format("/subscriptions/%s", data.azurerm_client_config.this.subscription_id)
  role = "Owner"
}

module "argocd_sso" {
  source = "../modules/azure/sso"

  application = "ArgoCD"
  redirect_uri = format("https://%s/auth/callback", format("argocd.mgmt.%s", var.domain))
  roles = local.roles
}

module "external_dns_service_account" {
  source = "../modules/azure/service_account"

  application = "External DNS"
  scope = var.willpxxr_com_dns_zone_id
  role = "DNS Zone Contributor"
}
