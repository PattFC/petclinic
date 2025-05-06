variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS region"
}

variable "secret_name" {
  type        = string
  description = "Name of the secret"
}

variable "eks_oidc_provider_arn" {
  type        = string
  description = "ARN of the EKS OIDC provider"
}

variable "eks_oidc_provider_url" {
  type        = string
  description = "URL of the EKS OIDC provider"
}
