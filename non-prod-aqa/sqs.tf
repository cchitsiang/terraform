// Default FIFO Queue
module "default_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name                       = "${var.env_prefix}.fifo"
  fifo_queue                 = true
  visibility_timeout_seconds = 90

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}.fifo/SQSDefaultPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account}:role/AppAdmins"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}.fifo"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.ec2-role.arn}"
      },
      "Action": [
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage",
        "SQS:SendMessage"
      ],
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}.fifo"
    }
  ]
}
EOF

  tags = merge(map(
        "Name", "${var.env_prefix}.fifo"
  ), var.common_tags)
}

// Chat FIFO Queue
module "chat_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name                       = "${var.env_prefix}-chat.fifo"
  fifo_queue                 = true
  visibility_timeout_seconds = 90

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-chat.fifo/SQSDefaultPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account}:role/AppAdmins"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-chat.fifo"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.ec2-role.arn}"
      },
      "Action": [
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage",
        "SQS:SendMessage"
      ],
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-chat.fifo"
    }
  ]
}
EOF

  tags = merge(map(
        "Name", "${var.env_prefix}-chat.fifo"
  ), var.common_tags)
}

// Async FIFO Queue
module "async_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name                       = "${var.env_prefix}-async.fifo"
  fifo_queue                 = true
  visibility_timeout_seconds = 90

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-async.fifo/SQSDefaultPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account}:role/AppAdmins"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-async.fifo"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.ec2-role.arn}"
      },
      "Action": [
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage",
        "SQS:SendMessage"
      ],
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-async.fifo"
    }
  ]
}
EOF

  tags = merge(map(
        "Name", "${var.env_prefix}-async.fifo"
  ), var.common_tags)
}

// ChatOverflow FIFO Queue
module "chatoverflow_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name                       = "${var.env_prefix}-chatoverflow.fifo"
  fifo_queue                 = true
  visibility_timeout_seconds = 90

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-chatoverflow.fifo/SQSDefaultPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account}:role/AppAdmins"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-chatoverflow.fifo"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.ec2-role.arn}"
      },
      "Action": [
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage",
        "SQS:SendMessage"
      ],
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-chatoverflow.fifo"
    }
  ]
}
EOF

  tags = merge(map(
        "Name", "${var.env_prefix}-chatoverflow.fifo"
  ), var.common_tags)
}

// AsyncOverflow FIFO Queue
module "asyncoverflow_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 2.0"

  name                       = "${var.env_prefix}-asyncoverflow.fifo"
  fifo_queue                 = true
  visibility_timeout_seconds = 90

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-asyncoverflow.fifo/SQSDefaultPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account}:role/AppAdmins"
      },
      "Action": "SQS:*",
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-asyncoverflow.fifo"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.ec2-role.arn}"
      },
      "Action": [
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage",
        "SQS:SendMessage"
      ],
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-asyncoverflow.fifo"
    }
  ]
}
EOF

  tags = merge(map(
        "Name", "${var.env_prefix}-asyncoverflow.fifo"
  ), var.common_tags)
}
