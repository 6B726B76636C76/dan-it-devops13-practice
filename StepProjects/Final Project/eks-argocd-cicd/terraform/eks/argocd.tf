locals {
  argocd_hostname = "argocd.${data.terraform_remote_state.dns.outputs.domain_name}"
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.7.11"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = false
  timeout          = 600

  values = [
    yamlencode({
      configs = {
        params = {
          "server.insecure" = true
        }
      }
      server = {
        ingress = {
          enabled          = true
          ingressClassName = "nginx"
          hostname         = local.argocd_hostname
          annotations = {
            "nginx.ingress.kubernetes.io/backend-protocol" = "HTTP"
          }
        }
      }
    })
  ]

  depends_on = [helm_release.nginx_ingress]
}