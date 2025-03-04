output "eks-iam-cluster" {
  value = aws_iam_role.test-eks_iam_cluster
}

output "eks-iam-nodes" {
  value = aws_iam_role.test-eks_iam_nodes
}

output "eks-cluster-policy-attachment" {
  value = aws_iam_role_policy_attachment.test-eks_iam_cluster_AmazonEKSClusterPolicy
}

output "eks-cluster-resource-attachment" {
  value = aws_iam_role_policy_attachment.test-eks_iam_cluster_AmazonEKSVPCResourceControllery
}

output "eks-worker-node-policy-attachment" {
  value = aws_iam_role_policy_attachment.test-eks_iam_cluster_AmazonEKSWorkerNodePolicy
}

output "eks-worker-cni-policy-attachment" {
  value = aws_iam_role_policy_attachment.test-eks_iam_cluster_AmazonEKS_CNI_Policy
}

output "eks-worker-ec2-policy-attachment" {
  value = aws_iam_role_policy_attachment.test-eks_iam_cluster_AmazonEC2ContainerRegistryReadOnly
}

