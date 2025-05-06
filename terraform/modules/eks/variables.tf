variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role for EKS cluster (created in iam module)"
}

variable "cluster_version" {
  type        = string
  default     = "1.32"
  description = "EKS cluster version"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for EKS & Fargate"
}

variable "node_role_arn" {
  type        = string
  description = "IAM role for EKS node group (created in iam module)"
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

variable "ebs_csi_driver_role_arn" {
  type        = string
  description = "IAM role for EBS CSI driver"
}