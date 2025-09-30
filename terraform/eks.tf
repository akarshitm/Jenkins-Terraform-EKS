module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  # Cluster Configuration
  cluster_name                  = local.name
  cluster_version               = "1.32"  # Compatible with AL2_x86_64 AMI
  cluster_endpoint_public_access = true

  # Addons
  cluster_addons = {
    coredns   = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni   = { most_recent = true }
  }

  # VPC
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  # Managed Node Groups Defaults
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"   # Correct for Kubernetes 1.32
    instance_types = ["t2.medium"]
    attach_cluster_primary_security_group = true
  }

  # Managed Node Groups
  eks_managed_node_groups = {
    cluster-wg = {
      min_size      = 1
      max_size      = 2
      desired_size  = 1
      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"
      tags = { ExtraTag = "helloworld" }
    }
  }

  # Tags
  tags = local.tags
}
