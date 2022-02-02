variable "client_secret" {}

provider azurerm {
  features {}
  subscription_id = "a653fcc5-5b9c-4d8e-820d-7cd61fb8c3d8"
  tenant_id = "f96bf61a-8913-4999-9e1d-eff3a996f979"
  client_id = "7e278bb3-6f57-40c4-ad50-04ba578f89bf"
  client_secret = var.client_secret
}
