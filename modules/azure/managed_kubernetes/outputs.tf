output "host" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.host
  depends_on = [azurerm_kubernetes_cluster.this]
}

output "ca_cert" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate
  sensitive = true
  depends_on = [azurerm_kubernetes_cluster.this]
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
  sensitive = true
  depends_on = [azurerm_kubernetes_cluster.this]
}

output "client_key" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.client_key
  sensitive = true
  depends_on = [azurerm_kubernetes_cluster.this]
}
