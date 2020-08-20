provider "aws" {
  region = "eu-central-1"
}
resource "aws_s3_bucket" "tfstate_eschool" {
  bucket = "eschool-proj-tfstate-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }
}