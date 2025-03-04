output "eks-sg-control-plane" {
  value = aws_security_group.test-eks_sg_controlplane
}

output "eks-sg-nodes" {
  value = aws_security_group.test-eks_sg_nodes
}