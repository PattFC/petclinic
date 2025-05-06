provider "aws" {
  region = var.region
}

module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  cluster_name =  var.cluster_name
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "eks" {
  source                    = "./modules/eks"
  cluster_name              = var.cluster_name
  cluster_role_arn          = module.iam.eks_cluster_role_arn
  node_role_arn             = module.iam.eks_node_group_role_arn
  subnet_ids                = module.vpc.private_subnet_ids
  cluster_version           = var.cluster_version
  node_group_desired_size   = var.node_group_desired_size
  node_group_min_size       = var.node_group_min_size
  node_group_max_size       = var.node_group_max_size
  node_disk_size            = var.node_disk_size
  instance_types            = var.instance_types
  ebs_csi_driver_role_arn   = module.iam.ebs_csi_driver_role_arn
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.this.token
  cluster_ca_certificate = base64decode(module.eks.cluster_ca)
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    token                  = data.aws_eks_cluster_auth.this.token
    cluster_ca_certificate = base64decode(module.eks.cluster_ca)
  }
}

module "iam" {
  source                = "./modules/iam"
  cluster_name          = var.cluster_name
  eks_oidc_provider_url = module.eks.oidc_provider_url
  eks_oidc_provider_arn = module.eks.oidc_provider_arn
  region                = var.region
  secret_name           = var.secret_name
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name = var.cluster_name
  addon_name   = "aws-ebs-csi-driver"
  addon_version = "v1.30.0-eksbuild.1"
  service_account_role_arn = module.iam.ebs_csi_driver_role_arn

  depends_on = [module.eks, module.iam]
}

resource "kubernetes_storage_class" "ebs_storage_class" {
  metadata {
    name = "gp3" 
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
  reclaim_policy      = "Delete"

  parameters = {
    type = "gp3"
  }

  allow_volume_expansion = true
}
