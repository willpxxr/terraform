provider "helm" {
  kubernetes {
    host = var.kubernetes_host
    client_certificate = base64decode(var.client_certificate)
    client_key = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace = "argocd"
  create_namespace = true

  values = [
    <<-EOF
      server:
        extraArgs:
          - --insecure
        ingress:
          enabled: true
          annotations: {}
          ingressClassName: nginx
          hosts:
            - ${var.argocd_ingress_domain}
          paths:
            - /
          pathType: Prefix
          tls:
            - hosts:
                - ${var.argocd_ingress_domain}
              secretName: argocd-server-tls
        config:
          url: https://${var.argocd_ingress_domain}
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
        rbacConfig:
          policy.default: "role:readonly"
          policy.csv: |
            ${indent(6, join("\n", [for role in var.argocd_sso_roles: format("g, %s, role:%s", role.id, role.name)]))}
          scopes: '[roles]'
        additionalProjects:
          - name: bootstrap
            namespace: argocd
            finalizers:
              - resources-finalizer.argocd.argoproj.io
            description: Cluster Bootstrap Project
            sourceRepos:
              - '*'
            destinations:
              - namespace: '*'
                server: '*'
            clusterResourceWhitelist:
              - group: '*'
                kind: '*'
        additionalApplications:
          - name: bootstrap
            namespace: argocd
            finalizers:
              - resources-finalizer.argocd.argoproj.io
            project: bootstrap
            source:
              repoURL: https://github.com/willpxxr/gitops
              targetRevision: HEAD
              path: bootstrap
            destination:
              server: https://kubernetes.default.svc
              namespace: argocd
            syncPolicy:
              automated:
                selfHeal: true
                prune: true
            info:
              - name: url
                value: https://github.com/willpxxr/gitops/tree/main/bootstrap
        extensions:
          contents:
            - name: argo-rollouts
              url: https://github.com/argoproj-labs/rollout-extension/releases/download/v0.1.0/extension.tar
      configs:
        credentialTemplates:
          https-creds:
            url: https://github.com/willpxxr
            username: willpxxr
            password: ${var.argocd_github_access_token}
        secret:
          githubSecret: ${var.argocd_github_access_token}
          extra:
            oidc.azure.clientSecret: ${var.argocd_sso_client_secret}
    EOF
  ]
}

resource "helm_release" "applicationset" {
  name       = "applicationset"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-applicationset"
  namespace  = "argocd"
  create_namespace = true

  depends_on = [
    helm_release.argocd
  ]
}
