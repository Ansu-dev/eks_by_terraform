resource "aws_s3_bucket" "terraform-state-s3" {
  bucket = var.bucket_name
  tags = {
    Name = "terraform-state-s3"
  }
}