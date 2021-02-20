env_name         = "AQA"
aws_account      = "080007210919"
aws_region       = "us-east-1"
vpc_id           = "vpc-55ae792d"
env_prefix       = "nvsimplr-aqa"
domain_zone      = "gosimplr.com."
env_domain       = "aqa.gosimplr.com"
email            = "simplr-cloud-team@simplr.ai"
subnets_external = ["subnet-b6e460d2", "subnet-b9977296", "subnet-7a78dc31"]
subnets_internal = ["subnet-9f7fdbd4", "subnet-728e6b5d", "subnet-b1d256d5"]
ec2_pem_key      = "nvsimplr-qa-nonprod"
ecs_ec2_ami_id   = "ami-04517ed529416fadf" // amzn-ami-2018.03.20200205-amazon-ecs-optimized

redis_subnet_group_name = "us-nva-npr-simplr-cache-internal-subnet-grp"

common_tags      = {
    BUSINESS_REGION   = "NORTHAMERICA"
    BUSINESS_UNIT     = "NEWVENTURES"
    CLIENT            = "MULTI_TENANT"
    PLATFORM          = "SIMPLR"
    ResourceCreatedBy = "swarnalakshmi.vedal"
    ENVIRONMENT       = "AQA"
}
