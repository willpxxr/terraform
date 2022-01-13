output "client_id" {
  value = azuread_application.this.application_id
}

output "tenant_id" {
  value = data.azuread_client_config.this.tenant_id
}

output "secret" {
  value = azuread_application_password.this.value
  sensitive = true
}
