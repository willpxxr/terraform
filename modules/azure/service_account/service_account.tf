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

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.id
}

resource "azurerm_role_assignment" "this" {
  principal_id = azuread_service_principal.this.id
  scope        = var.scope
  role_definition_name = var.role
}
