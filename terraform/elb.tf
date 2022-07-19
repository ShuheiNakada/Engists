# -------------------------------------------
# ALB
# -------------------------------------------
### ALB本体 ###
resource "aws_lb" "alb" {
  name               = "${var.tool}-${var.project}-${var.environment}-alb"
  load_balancer_type = "application"
  internal           = false
  # enablenable_deletion_protection = true

  subnets = [
    aws_subnet.ecs_public_subnet_1a.id,
    aws_subnet.ecs_public_subnet_1c.id,
  ]

  # access_logs {
  #   bucket = aws_s3_bucket.alb_accesslogs_bucket.id
  #   enabled = true
  # }

  security_groups = [
    aws_security_group.ecs_sg.id
  ]
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

### リスナー ###
## 1.HTTPリスナー ##
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

## 2.プロダクションリスナー(HTTPS) ##
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.tokyo_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue_tg.arn
  }
}

## 3.テストリスナー(カスタムTCP：10080) ##
resource "aws_lb_listener" "custom_10080" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "10080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green_tg.arn
  }
}

# -------------------------------------------
# TargetGroup
# -------------------------------------------
### 1.blue target group ###
resource "aws_lb_target_group" "blue_tg" {
  name                 = "${var.tool}-${var.project}-${var.environment}-blue-tg"
  target_type          = "ip"
  vpc_id               = aws_vpc.vpc.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/api/healthcheck"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 15
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.alb]
}

### 2.green target group ###
resource "aws_lb_target_group" "green_tg" {
  name                 = "${var.tool}-${var.project}-${var.environment}-green-tg"
  target_type          = "ip"
  vpc_id               = aws_vpc.vpc.id
  port                 = 10080
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/api/healthcheck"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 15
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.alb]
}

