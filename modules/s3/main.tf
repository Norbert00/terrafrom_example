terraform {
  required_version = ">= 0.12"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl = var.bucket_acl

  tags = var.bucket_s3_tag

}

resource "aws_s3_bucket_public_access_block" "bucket_block_public_access" {
    bucket = aws_s3_bucket.bucket.bucket

    block_public_acls = var.block_public_acls
    block_public_policy = var.block_public_policy
    ignore_public_acls = var.ignore_public_acls
    restrict_public_buckets = var.restrict_public_buckets

}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.bucket_versioning
  }
}

