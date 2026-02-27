resource "aws_eks_node_group" "production" {
  cluster_name    = var.cluster_name
  node_group_name = "production-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 3
  }

  instance_types = ["m6i.large"]
  capacity_type  = "ON_DEMAND"

  labels = {
    workload = "production"
  }
}

resource "aws_eks_node_group" "spot" {
  cluster_name    = var.cluster_name
  node_group_name = "spot-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  capacity_type  = "SPOT"
  instance_types = ["m6i.large"]
}