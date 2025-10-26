provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket-12345"
  
  # Intentionally misconfigured: public access
  acl    = "public-read"
}

