
resource "aws_eks_cluster" "danit" {
  name     = var.name
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.danit-cluster.id]
    subnet_ids = concat(
      data.terraform_remote_state.network.outputs.public_subnet_ids,
      data.terraform_remote_state.network.outputs.private_subnet_ids
    )
  }

  depends_on = [
    aws_iam_role_policy_attachment.kubeedge-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.kubeedge-cluster-AmazonEKSVPCResourceController,
  ]
  tags = merge(
    var.tags,
    { Name = "${var.name}" }
  )
}


data "aws_eks_cluster_auth" "danit" {
  name = aws_eks_cluster.danit.name
}



resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.danit.name
  addon_name    = "coredns"
  addon_version = "v1.14.3-eksbuild.14"

  resolve_conflicts_on_create = "OVERWRITE"

  depends_on = [aws_eks_node_group.danit]
}