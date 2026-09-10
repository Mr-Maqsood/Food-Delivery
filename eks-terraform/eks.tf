module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      name           = "food-delivery-nodes"
      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"

      min_size     = 2
      max_size     = 4
      desired_size = 2

      disk_size = 20
    }
  }

  # Aapka IAM user cluster admin ban jaye automatically
  enable_cluster_creator_admin_permissions = true

  tags = {
    Project = "food-delivery"
  }
}