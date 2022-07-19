# -------------------------------------------
# SecurtyGroup
# -------------------------------------------
### 1.ECS用 ###
resource "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-ecs-sg"
  }
}

resource "aws_security_group_rule" "ecs_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}

resource "aws_security_group_rule" "ecs_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}

resource "aws_security_group_rule" "ecs_ingress_custom_tcp" {
  type              = "ingress"
  from_port         = "10080"
  to_port           = "10080"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}

resource "aws_security_group_rule" "ecs_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}

### 2. DB用 ###
resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-db-sg"
  }
}

resource "aws_security_group_rule" "db_ingress_mysql_from_ecs" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_sg.id
  security_group_id        = aws_security_group.db_sg.id
}

resource "aws_security_group_rule" "db_egress_mysql" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db_sg.id
}