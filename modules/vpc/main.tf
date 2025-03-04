resource "aws_vpc" "eks_vpc" {
  cidr_block = var.aws_vpc_cidr_block # ip대역대(ip와 서브넷마스크를 조합하여 블록 생성)

  tags = {
    Name = "eks-vpc"
  } # VPC 태그 설정
}

resource "aws_internet_gateway" "eks_igw" {
  depends_on = [aws_vpc.eks_vpc]

  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks-igw"
  }
}

resource "aws_route_table" "eks_route_table" {
  depends_on = [
    aws_vpc.eks_vpc,
    aws_internet_gateway.eks_igw
  ]

  vpc_id = aws_vpc.eks_vpc.id

  # 라우트 정보
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name = "eks-route-table"
  }
}

resource "aws_route_table_association" "test-route-association-pub-sub" {

  count = length(var.aws_vpc_public_subnets)
  subnet_id = var.eks-public-subnet[count.index].id
  route_table_id = aws_route_table.eks_route_table.id

}