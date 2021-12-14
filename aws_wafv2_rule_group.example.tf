resource "aws_wafv2_rule_group" "example" {
  name     = "example-rule"
  scope    = "REGIONAL"
  capacity = 2

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

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}
