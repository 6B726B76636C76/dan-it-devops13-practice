resource "helm_release" "argocd_image_updater" {
  name             = "argocd-image-updater"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-image-updater"
  version          = "0.12.1"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = false

  depends_on = [helm_release.argocd]
}

resource "kubernetes_secret" "git_creds" {
  metadata {
    name      = "git-creds"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }
  data = {
    sshPrivateKey = var.image_updater_ssh_private_key
  }
  type = "Opaque"
}