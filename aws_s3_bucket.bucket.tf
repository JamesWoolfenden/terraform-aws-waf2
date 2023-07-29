
resource "aws_s3_bucket" "bucket" {
  #checkov:skip=CKV_AWS_21: Versioning not appropriate
  #checkov:skip=CKV_AWS_144: Cross region not required
  #checkov:skip=CKV_AWS_18: No access logs
  #checkov:skip=CKV2_AWS_37:Versioning not appropriate
  #checkov:skip=CKV2_AWS_41:V4 now legacy
  #checkov:skip=CKV_AWS_145:V4 now legacy
  #checkov:skip=CKV_AWS_19:V4 now legacy
  #checkov:skip=CKV2_AWS_62: Noisy
  bucket = local.waf_bucket
}


resource "aws_s3_bucket_public_access_block" "name" {
  bucket                  = aws_s3_bucket.bucket.id
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
}


resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}
