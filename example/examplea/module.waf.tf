module "waf" {
  source      = "../../"
  kms_key_arn = aws_kms_key.waf.arn
}


resource "aws_kms_key" "waf" {
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
