provider "helm" {
  kubernetes {
    host = var.kubernetes_host
    client_certificate = base64decode(var.client_certificate)
    client_key = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

resource "helm_release" "this" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace = "argocd"
  create_namespace = true

  values = [
    <<-EOF
      server:
        ingress:
          enabled: true
          annotations: {}
          ingressClassName: ""
          hosts:
            - willpxxr.com
          paths:
            - /
          pathType: Prefix
        config:
          url: https://localhost:8080
          oidc.config: |
            name: Azure
            issuer: https://login.microsoftonline.com/${var.argocd_sso_tenant_id}/v2.0
            clientID: ${var.argocd_sso_client_id}
            clientSecret: $oidc.azure.clientSecret
            requestedIDTokenClaims:
              groups:
                essential: true
            requestedScopes:
              - openid
              - profile
              - email
        extensions:
          contents:
            - name: argo-rollouts
              url: https://github.com/argoproj-labs/rollout-extension/releases/download/v0.1.0/extension.tar
      configs:
        secret:
          extra:
            oidc.azure.clientSecret: ${var.argocd_sso_client_secret}
    EOF
  ]
}
