resource "aws_wafv2_web_acl" "example" {
  name = local.waf_name
  default_action {
    allow {

    }
  }
  visibility_config {
    metric_name                = "eightklimit"
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
  }

  rule {
    name     = "8klimit"
    priority = 0

    action {

      block {
      }
    }

    statement {

      size_constraint_statement {
        comparison_operator = "GE"
        size                = 8192

        field_to_match {

          body {}
        }

        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "8klimit"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "aws-managed-known-bad-inputs"
    priority = 1
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-managed-known-bad-inputs"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "aws-managed-common-rule-set"
    priority = 2
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }
          name = "SizeRestrictions_BODY"
        }

        rule_action_override {
          action_to_use {
            count {}
          }
          name = "CrossSiteScripting_COOKIE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-managed-common-rule-set"
      sampled_requests_enabled   = true
    }
  }

  scope = "REGIONAL"
}
