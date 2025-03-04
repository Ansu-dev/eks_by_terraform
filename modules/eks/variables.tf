variable "cluster-name" {
  default = "test-eks-cluster"
  type    = string
}
variable "eks-iam-cluster" {}
variable "eks-iam-nodes" {}
variable "eks-cluster-policy-attachment" {}
variable "eks-cluster-resource-attachment" {}
variable "eks-worker-node-policy-attachment" {}
variable "eks-worker-cni-policy-attachment" {}
variable "eks-worker-ec2-policy-attachment" {}

variable "eks-public-subnet" {}

variable "eks-sg-control-plane" {}
variable "eks-sg-nodes" {}