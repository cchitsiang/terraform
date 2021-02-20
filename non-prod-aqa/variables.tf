variable "env_name" {
  type = string
}

variable "aws_account" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "env_prefix" {
  type = string
}

variable "domain_zone" {
  type = string
}

variable "env_domain" {
  type = string
}

variable "email" {
  type = string
}

variable "subnets_internal" {
  type    = list(string)
}

variable "subnets_external" {
  type    = list(string)
}

variable "redis_subnet_group_name" {
  type = string
}

variable "ec2_pem_key" {
  type = string
}

variable "ecs_ec2_ami_id" {
  type = string
}

variable "common_tags" {
  type = map(string)

  default = {
    BUSINESS_REGION   = "NORTHAMERICA"
    BUSINESS_UNIT     = "NEWVENTURES"
    CLIENT            = "MULTI_TENANT"
    PLATFORM          = "SIMPLR"
  }
}
