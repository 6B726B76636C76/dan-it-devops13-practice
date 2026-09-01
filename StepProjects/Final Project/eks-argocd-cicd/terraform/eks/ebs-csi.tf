module "ebs-csi-driver" {
  source  = "DrFaust92/ebs-csi-driver/kubernetes"
  version = "3.10.0"

  oidc_url                = aws_eks_cluster.danit.identity[0].oidc[0].issuer
  enable_volume_resizing  = true
}