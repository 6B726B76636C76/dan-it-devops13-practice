resource "kubernetes_secret" "argocd_repo_creds" {
  metadata {
    name      = "repo-eks-argocd-cicd"
    namespace = kubernetes_namespace.argocd.metadata[0].name
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }
  data = {
    type     = "git"
    url      = "https://github.com/6B726B76636C76/eks-argocd-cicd.git"
    username = "6B726B76636C76"
    password = var.github_pat
  }
}