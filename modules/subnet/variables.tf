variable "eks_vpc" {}

variable "aws_availability_zones" {
  description = "서브넷이 배치될 가용 영역 리스트"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]  # 필요한 AZ 개수만큼 추가
}

variable "aws_vpc_public_subnets" {}