variable "region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS region"
}

variable "cluster_name" {
  type        = string
  description = "EKS Cluster name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "lifecycle_ignore_changes" {
  type        = bool
  default     = true
  description = "Whether to ignore changes to secret value"
}

variable "secret_name" {
  type        = string
  description = "Name of the secret"
}

variable "secret_username" {
  description = "Username for the PetClinic database"
  type        = string
}

variable "secret_description" {
  type        = string
  description = "Description of the secret"
}

variable "cluster_version" {
  type        = string
  default     = "1.32"
  description = "EKS cluster version"
}

variable "node_group_desired_size" {
  type        = number
  default     = 2
  description = "Desired size of the EKS node group"
}

variable "node_group_max_size" {
  type        = number
  default     = 1
  description = "Maximum size of the EKS node group"
}

variable "node_group_min_size" {
  type        = number
  default     = 1
  description = "Minimum size of the EKS node group"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "Instance types for the EKS node group"
}

variable "node_disk_size" {
  type        = number
  default     = 20
  description = "Disk size for the EKS node group"
}
