
locals {
  firehose_name = "waf-stream-${random_string.Unique.id}"
  firehose_role = "firehose-waf-${random_string.Unique.id}"
  waf_bucket    = "waf-${random_string.Unique.id}-${data.aws_caller_identity.current.account_id}"
  waf_name      = "waf-${random_string.Unique.id}"
}
