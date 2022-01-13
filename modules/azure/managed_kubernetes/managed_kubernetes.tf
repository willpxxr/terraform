module "resource-group" {
  source = "../resource_group"

  name = format("%s-%s", "willpxxr", var.name)
  zone = var.zone
}

resource "azurerm_kubernetes_cluster" "this" {
  depends_on = [module.resource-group]

  dns_prefix = format("%s-%s", "willpxxr", var.name)
  location = var.zone
  name = var.name
  resource_group_name = format("%s-%s", "willpxxr", var.name)

  default_node_pool {
    node_count = 1
    name = "default"
    vm_size = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
