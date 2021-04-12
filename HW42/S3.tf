provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "/root/.aws/credentials "
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "aleks-tf-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "b" {
  bucket = "aleksandr-korol-s3-terraform"
  acl    = "public-read"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.b.id
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
  content_type = "text/html"
}