module "vpc" {
  source = "./modules/vpc"
  name   = "eks-vpc"
  cidr   = "10.0.0.0/16"

  azs = ["us-east-1a","us-east-1b","us-east-1c"]

  private_subnets = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]

  environment = "prod"
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source            = "./modules/eks"
  cluster_name      = "production-eks"
  cluster_version   = "1.34"
  cluster_role_arn  = module.iam.cluster_role_arn
  private_subnets   = module.vpc.private_subnets
}

module "nodegroups" {
  source          = "./modules/nodegroups"
  cluster_name    = module.eks.cluster_name
  node_role_arn   = module.iam.node_role_arn
  private_subnets = module.vpc.private_subnets
}