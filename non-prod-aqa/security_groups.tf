module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name             = "${var.env_prefix}-alb"
  description      = "${var.env_prefix}-alb"
  use_name_prefix  = false
  vpc_id           = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = ""
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = ""
    }
  ]

  ingress_with_ipv6_cidr_blocks = [
    {
      rule              = "http-80-tcp"
      ipv6_cidr_blocks  = "::/0"
      description       = ""
    },
    {
      rule              = "https-443-tcp"
      ipv6_cidr_blocks  = "::/0"
      description       = ""
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule         = "all-all"
      cidr_blocks  = "0.0.0.0/0"
      description  = ""
    }
  ]

  tags = var.common_tags
}

module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name             = "${var.env_prefix}-ec2"
  description      = "${var.env_prefix}-ec2"
  use_name_prefix  = false
  vpc_id           = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                      = "all-all"
      source_security_group_id  = module.alb_sg.this_security_group_id
      description               = ""
    }
  ]

  ingress_with_cidr_blocks = [
    {
      rule         = "ssh-tcp"
      cidr_blocks  = "10.0.0.0/8"
      description  = ""
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule         = "all-all"
      cidr_blocks  = "0.0.0.0/0"
      description  = ""
    }
  ]

  tags = var.common_tags
}

module "redis_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name             = "${var.env_prefix}-redis"
  description      = "${var.env_prefix}-redis"
  use_name_prefix  = false
  vpc_id           = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                      = "redis-tcp"
      source_security_group_id  = module.ec2_sg.this_security_group_id
      description               = ""
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
      description = ""
    }
  ]

  tags = var.common_tags
}
