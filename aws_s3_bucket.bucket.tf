resource "aws_s3_bucket" "bucket" {
  #checkov:skip=CKV_AWS_21: Versioning not appropriate
  #checkov:skip=CKV_AWS_144: Cross region not required
  #checkov:skip=CKV_AWS_18: No access logs
  bucket = local.waf_bucket
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


resource "aws_s3_bucket_public_access_block" "name" {
  bucket                  = aws_s3_bucket.bucket.id
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
}
