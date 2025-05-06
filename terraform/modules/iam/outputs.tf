output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}

output "eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}

output "eks_node_group_role_name" {
  value = aws_iam_role.eks_node_group_role.name
}

output "petclinic_irsa_role_arn" {
  description = "IAM Role ARN for petclinic IRSA access"
  value       = aws_iam_role.petclinic_irsa.arn
}

output "ebs_csi_driver_role_arn" {
  description = "IAM Role ARN for EBS CSI driver"
  value       = aws_iam_role.ebs_csi_driver.arn
}
