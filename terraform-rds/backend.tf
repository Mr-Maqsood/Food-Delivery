terraform {
  backend "s3" {
    bucket         = "terraform-bucket-1-2026"
    key            = "rds/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
