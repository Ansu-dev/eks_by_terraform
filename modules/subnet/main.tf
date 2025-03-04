resource "aws_subnet" "eks-public-subnet" {
  depends_on = [var.eks_vpc]

  count = length(var.aws_vpc_public_subnets)
  vpc_id = var.eks_vpc.id
  cidr_block = var.aws_vpc_public_subnets[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-subnet${count.index+1}"
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
  }
}