data "azuread_client_config" "this" {}

resource "azuread_application" "this" {
  display_name = var.application

  owners = [
    data.azuread_client_config.this.object_id
  ]
}

resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id

  owners = [
    data.azuread_client_config.this.object_id
  ]
}
