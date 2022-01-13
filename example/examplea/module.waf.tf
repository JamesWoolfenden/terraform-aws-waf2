module "waf" {
  source      = "../../"
  kms_key_arn = aws_kms_key.waf.arn
}


resource "aws_kms_key" "waf" {
  enable_key_rotation = true
}
