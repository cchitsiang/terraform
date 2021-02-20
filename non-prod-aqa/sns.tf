// Inbound Email Topic
module "inbound_email_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 2.0"

  name  = "${var.env_prefix}-inbound-email"
  tags  = var.common_tags
}

resource "aws_sns_topic_subscription" "inbound_email_topic_subscription" {
  topic_arn               = module.inbound_email_topic.this_sns_topic_arn
  protocol                = "https"
  endpoint                = "https://${var.env_domain}/api/sns/inbound/email"
  endpoint_auto_confirms  = true
}

// Inbound SMS Topic
module "inbound_sms_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 2.0"

  name  = "${var.env_prefix}-inbound-sms"
  tags  = var.common_tags
}

resource "aws_sns_topic_subscription" "inbound_sms_topic_subscription" {
  topic_arn               = module.inbound_sms_topic.this_sns_topic_arn
  protocol                = "https"
  endpoint                = "https://${var.env_domain}/api/sns/inbound/sms"
  endpoint_auto_confirms  = true
}

// Inbound Ticketing Topic
module "inbound_ticketing_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 2.0"

  name  = "${var.env_prefix}-inbound-ticketing"
  tags  = var.common_tags
}

resource "aws_sns_topic_subscription" "inbound_ticketing_topic_subscription" {
  topic_arn               = module.inbound_ticketing_topic.this_sns_topic_arn
  protocol                = "https"
  endpoint                = "https://${var.env_domain}/api/sns/inbound/ticketing"
  endpoint_auto_confirms  = true
}

// DevOps Alerts Topic
module "devops_alerts_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 2.0"

  name  = "${var.env_prefix}-DevOpsAlerts"
  tags  = var.common_tags
}
