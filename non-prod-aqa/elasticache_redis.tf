// ElastiCache Redis primary Multi AZ
resource "aws_elasticache_replication_group" "redis_primary" {
  engine                        = "redis"
  replication_group_id          = "${var.env_prefix}-1"
  replication_group_description = "Redis ${var.env_name} primary"
  node_type                     = "cache.t2.micro"
  number_cache_clusters         = 2
  parameter_group_name          = "default.redis5.0"
  engine_version                = "5.0.6"
  port                          = 6379
  automatic_failover_enabled    = true
  availability_zones            = ["${var.aws_region}a", "${var.aws_region}b"]
  subnet_group_name             = var.redis_subnet_group_name
  security_group_ids            = [module.redis_sg.this_security_group_id]
  snapshot_retention_limit      = 1

  tags = var.common_tags
}

// ElastiCache Redis secondary
resource "aws_elasticache_cluster" "redis_secondary" {
  cluster_id               = "${var.env_prefix}-2"
  engine                   = "redis"
  node_type                = "cache.t2.micro"
  num_cache_nodes          = 1
  parameter_group_name     = "default.redis5.0"
  engine_version           = "5.0.6"
  port                     = 6379
  subnet_group_name        = var.redis_subnet_group_name
  security_group_ids       = [module.redis_sg.this_security_group_id]
  snapshot_retention_limit = 1

  tags = var.common_tags
}

// ElastiCache Redis third
resource "aws_elasticache_cluster" "redis_third" {
  cluster_id               = "${var.env_prefix}-3"
  engine                   = "redis"
  node_type                = "cache.t2.micro"
  num_cache_nodes          = 1
  parameter_group_name     = "default.redis5.0"
  engine_version           = "5.0.6"
  port                     = 6379
  subnet_group_name        = var.redis_subnet_group_name
  security_group_ids       = [module.redis_sg.this_security_group_id]
  snapshot_retention_limit = 1

  tags = var.common_tags
}
