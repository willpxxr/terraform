variable "kubernetes_host" {
  type = string
  description = "The hostname of the kubernetes cluster to install argoCD on"
}

variable "client_certificate" {
  type = string
  description = "The client certificate to provide authentication to the kubernetes cluster"
}

variable "client_key" {
  type = string
  description = "The client key to provide authentication to the kubernetes cluster"
}

variable "cluster_ca_certificate" {
  type = string
  description = "The cluster CA certificate"
}

variable "argocd_sso_client_secret" {}

variable "argocd_sso_client_id" {}

variable "argocd_sso_tenant_id" {}
