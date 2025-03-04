resource "aws_subnet" "eks-public-subnet" {
  depends_on = [var.eks_vpc]

  count = length(var.aws_vpc_public_subnets)
  vpc_id = var.eks_vpc.id
  cidr_block = var.aws_vpc_public_subnets[count.index]
  availability_zone = var.aws_availability_zones[count.index]  # 각 서브넷을 다른 AZ에 배치, EKS는 AZs를 사용하야함
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-subnet${count.index+1}"
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
  }
}