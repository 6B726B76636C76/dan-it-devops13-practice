resource "kubectl_manifest" "argocd_app" {
  yaml_body = <<-YAML
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: argocd-project-app
      namespace: argocd
      annotations:
        argocd-image-updater.argoproj.io/image-list: "app=zinchevm/argocd-project-app:latest"
        argocd-image-updater.argoproj.io/app.update-strategy: "digest"
        argocd-image-updater.argoproj.io/write-back-method: "git"
        argocd-image-updater.argoproj.io/git-branch: "main"
    spec:
      project: default
      source:
        repoURL: https://github.com/6B726B76636C76/eks-argocd-cicd.git
        targetRevision: main
        path: k8s
      destination:
        server: https://kubernetes.default.svc
        namespace: default
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
  YAML

  depends_on = [helm_release.argocd, helm_release.argocd_image_updater]
}