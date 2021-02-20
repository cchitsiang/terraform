// ALB
resource "aws_lb" "alb" {
  name               = "${var.env_prefix}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.alb_sg.this_security_group_id]
  subnets            = var.subnets_external

  tags = merge(map(
        "Name", "${var.env_prefix}-lb"
  ), var.common_tags)
}

// ALB Default Target Group
resource "aws_lb_target_group" "web" {
  name     = "${var.env_prefix}-web"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/index.html?hc=4dC78mEK"
  }

  tags = var.common_tags
}

// ALB Listener HTTPS 443
resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-1-2017-01"
  certificate_arn   = aws_acm_certificate_validation.cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

// ALB Listener HTTP 80
resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

// Route 53 record PROD
resource "aws_route53_record" "alb_dns" {
  provider = aws.prod
  zone_id = data.aws_route53_zone.zone.id
  name    = var.env_domain
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
