resource "aws_wafv2_web_acl" "example" {
  name = "examplea"
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

  scope = "REGIONAL"
}