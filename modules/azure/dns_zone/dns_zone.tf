module "resource_group" {
  source = "../resource_group"
  name = format("%s-%s", "willpxxr", var.name)
  zone = var.zone
}

resource "azurerm_dns_zone" "this" {
  depends_on = [
    module.resource_group
  ]

  name                = var.name
  resource_group_name = format("%s-%s", "willpxxr", var.name)

  lifecycle {
    ignore_changes = [
      number_of_record_sets
    ]
  }
}
