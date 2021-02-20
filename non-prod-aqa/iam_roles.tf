// EC2 Role with inline policies
resource "aws_iam_role" "ec2-role" {
    name = "${var.env_prefix}-ec2"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
    tags = var.common_tags
}

resource "aws_iam_instance_profile" "iam-instance-profile" {
    name = "${var.env_prefix}-ec2"
    role = aws_iam_role.ec2-role.name
}

resource "aws_iam_role_policy" "policy-ecs-limited" {
    name = "${var.env_prefix}-ecs-limited"
    role = aws_iam_role.ec2-role.name
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:SubmitTaskStateChange",
                "ecs:Poll",
                "ecs:StartTelemetrySession",
                "ecr:GetDownloadUrlForLayer",
                "ecs:UpdateContainerInstancesState",
                "ecr:BatchGetImage",
                "ecs:RegisterContainerInstance",
                "ecs:SubmitContainerStateChange",
                "ecs:DeregisterContainerInstance",
                "logs:PutLogEvents",
                "ecr:BatchCheckLayerAvailability"
            ],
            "Resource": [
                "arn:aws:ecr:${var.aws_region}:${var.aws_account}:repository/${var.env_prefix}-*",
                "arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:${var.env_prefix}-*:*:*",
                "arn:aws:ecs:${var.aws_region}:${var.aws_account}:container-instance/*",
                "arn:aws:ecs:${var.aws_region}:${var.aws_account}:cluster/${var.env_prefix}",
                "arn:aws:ecs:${var.aws_region}:${var.aws_account}:cluster/${var.env_prefix}*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecs:DiscoverPollEndpoint",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:${var.aws_region}:${var.aws_account}:log-group:${var.env_prefix}-*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "policy-kms-limited" {
    name = "${var.env_prefix}-kms-limited"
    role = aws_iam_role.ec2-role.name
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:DescribeKey",
                "kms:GenerateDataKeyPairWithoutPlaintext",
                "kms:GenerateDataKeyPair"
            ],
            "Resource": "arn:aws:kms:${var.aws_region}:${var.aws_account}:key/*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "policy-sns-limited" {
    name = "${var.env_prefix}-sns-limited"
    role = aws_iam_role.ec2-role.name
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sns:ListSubscriptionsByTopic",
                "sns:Publish",
                "sns:GetTopicAttributes",
                "sns:ConfirmSubscription"
            ],
            "Resource": "arn:aws:sns:${var.aws_region}:${var.aws_account}:${var.env_prefix}-*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "policy-sqs-limited" {
    name = "${var.env_prefix}-sqs-limited"
    role = aws_iam_role.ec2-role.name
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sqs:DeleteMessage",
                "sqs:GetQueueUrl",
                "sqs:ChangeMessageVisibility",
                "sqs:SendMessageBatch",
                "sqs:UntagQueue",
                "sqs:ReceiveMessage",
                "sqs:SendMessage",
                "sqs:GetQueueAttributes",
                "sqs:ListQueueTags",
                "sqs:TagQueue",
                "sqs:ListDeadLetterSourceQueues",
                "sqs:DeleteMessageBatch",
                "sqs:ChangeMessageVisibilityBatch"
            ],
            "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account}:${var.env_prefix}-*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "sqs:ListQueues",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "policy-s3-limited" {
    name = "${var.env_prefix}-s3-limited"
    role = aws_iam_role.ec2-role.name
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketNotification",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::${var.env_prefix}*/*",
                "arn:aws:s3:::${var.env_prefix}*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:PutObjectVersionAcl",
                "s3:DeleteObject",
                "s3:PutObjectAcl",
                "s3:GetObjectVersion"
            ],
            "Resource": "arn:aws:s3:::${var.env_prefix}*/*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy-gov-ssm-basic" {
  role       = aws_iam_role.ec2-role.name
  policy_arn = "arn:aws:iam::${var.aws_account}:policy/GOV_ssm_basic"
}
