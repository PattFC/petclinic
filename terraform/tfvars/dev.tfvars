region                    = "eu-north-1"

vpc_cidr                  = "10.0.0.0/16"
azs                       = ["eu-north-1a", "eu-north-1b"]
public_subnets            = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets           = ["10.0.11.0/24", "10.0.12.0/24"]

secret_name               = "..."
secret_username           = "..."
secret_description        = "..."
lifecycle_ignore_changes  = true

cluster_name              = "..."
cluster_version           = "1.32"
node_group_desired_size   = 2
node_group_min_size       = 1
node_group_max_size       = 3
node_disk_size            = 20
instance_types            = ["t3.medium"]
