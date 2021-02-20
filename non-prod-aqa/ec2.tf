// EC2 Instances for main ECS cluster
module "ecs_ec2_instances_main" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "${var.env_prefix}-ecs-instance"
  instance_count         = 3
  ami                    = var.ecs_ec2_ami_id
  instance_type          = "m4.xlarge"
  key_name               = var.ec2_pem_key
  monitoring             = false
  vpc_security_group_ids = [module.ec2_sg.this_security_group_id]
  subnet_ids             = var.subnets_internal
  iam_instance_profile   = aws_iam_role.ec2-role.name

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/xvdcz"
      volume_type = "gp2"
      volume_size = 50
    }
  ]

  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main_services.name} >> /etc/ecs/ecs.config
EOF

  tags = merge(map(
          "SCHEDULER:SLEEP", "ALTERNATIVE"
    ), var.common_tags)

  volume_tags = merge(map(
          "SCHEDULER:SLEEP", "ALTERNATIVE"
    ), var.common_tags)
}

// EC2 Instances for ML ECS cluster
module "ecs_ec2_instances_ml" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "${var.env_prefix}-ml-services-ecs-instance"
  instance_count         = 2
  ami                    = var.ecs_ec2_ami_id
  instance_type          = "m4.xlarge"
  key_name               = var.ec2_pem_key
  monitoring             = false
  vpc_security_group_ids = [module.ec2_sg.this_security_group_id]
  subnet_ids             = var.subnets_internal
  iam_instance_profile   = aws_iam_role.ec2-role.name

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/xvdcz"
      volume_type = "gp2"
      volume_size = 50
    }
  ]

  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.ml_services.name} >> /etc/ecs/ecs.config
EOF

  tags = merge(map(
          "SCHEDULER:SLEEP", "ALTERNATIVE"
    ), var.common_tags)

  volume_tags = merge(map(
          "SCHEDULER:SLEEP", "ALTERNATIVE"
    ), var.common_tags)
}
