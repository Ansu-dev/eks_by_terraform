resource "aws_dynamodb_table" "terraform-state-db" {
  depends_on = [var.terraform-s3-bucket]
  name = "terraform-state-db"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-state-db"
  }
}