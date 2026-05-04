module "waf" {
  source      = "../../"
  kms_key_arn = aws_kms_key.waf.arn
}
resource "aws_kms_key" "waf" {
  # checkov:skip=CKV2_AWS_64: For example only, key policy managed via IAM
  enable_key_rotation = true
  policy              = <<POLICY
{
  "Sid": "Enable IAM User Permissions",
  "Effect": "Allow",
  "Principal": {
    "AWS": "arn:aws:iam::${data.aws_caller_identity.current.id}:root"
   },
  "Action": "kms:*",
  "Resource": "*"
}
POLICY
}
data "aws_caller_identity" "current" {}
