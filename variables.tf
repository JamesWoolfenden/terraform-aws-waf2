variable "kms_key_arn" {
  type        = string
  description = "The ARN of a KMS key"
}

variable "scope" {
  type        = string
  default     = "REGIONAL"
  description = "Set to REGIONAL or CLOUDFRONT- if cloudfront this must be created in us-east-1"
}
