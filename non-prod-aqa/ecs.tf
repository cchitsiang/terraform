// ECS main services cluster
resource "aws_ecs_cluster" "main_services" {
  name = var.env_prefix
  tags = var.common_tags
}

// ECS ML services cluster
resource "aws_ecs_cluster" "ml_services" {
  name = "${var.env_prefix}-ml-services"
  tags = var.common_tags
