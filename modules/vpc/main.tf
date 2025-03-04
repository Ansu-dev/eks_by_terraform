resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16" # ip대역대(ip와 서브넷마스크를 조합하여 블록 생성)

  tags = {
    Name = "eks-vpc"
  } # VPC 태그 설정
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks-igw"
  }
}

resource "aws_route_table" "eks_route_table" {
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