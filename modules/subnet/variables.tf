variable "eks_vpc" {}

variable "aws_vpc_public_subnets" {
  default = ["172.31.0.0/20", "172.31.16.0/20"]
  type = list(string)
}