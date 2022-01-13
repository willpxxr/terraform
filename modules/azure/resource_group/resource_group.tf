resource "azurerm_resource_group" "this" {
  location = var.zone
  name = var.name
}
