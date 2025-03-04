# eks cluster
resource "aws_eks_cluster" "eks-cluster" {
  depends_on = [
    var.eks-cluster-policy-attachment,
    var.eks-cluster-resource-attachment
  ]

  name = var.cluster-name
  role_arn = var.eks-iam-cluster.arn
  version = "1.22"

  vpc_config{
    security_group_ids = [var.eks_sg_control-plane.id, var.eks_sg_nodes.id]
    subnet_ids = flatten([var.eks-public-subnet[*].id])
    endpoint_public_access = true
    public_access_cidrs = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "EKS-CLUSTER"
  }
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name  = var.cluster-name
  node_group_name = "eks-node-group"
  node_role_arn = var.eks-iam-nodes.arn
  subnet_ids = var.eks-public-subnet[*].id

  ami_type = "AL2_x86_64"
  capacity_type = "ON_DEMAND"
  instance_types = ["t3a.medium"]
  disk_size = 20

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    var.eks-worker-node-policy-attachment,
    var.eks-worker-cni-policy-attachment,
    var.eks-worker-ec2-policy-attachment
  ]

  tags = {
    Name = "EKS-WORKER-NODES"
  }
}