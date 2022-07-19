# -------------------------------------------
# ParameterGroup
# -------------------------------------------
resource "aws_db_parameter_group" "mysql_parametergroup" {
  name   = "${var.tool}-${var.project}-${var.environment}-mysql-parametergroup"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

# -------------------------------------------
# SubnetGroup
# -------------------------------------------
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name = "${var.tool}-${var.project}-${var.environment}-mysql-subnetgroup"
  subnet_ids = [
    aws_subnet.db_private_subnet_1a.id,
    aws_subnet.db_private_subnet_1c.id
  ]

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-mysql-subnetgroup"
  }
}

# -------------------------------------------
# RDS instance
# -------------------------------------------
resource "random_string" "db_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "mysql" {
  engine         = "mysql"
  engine_version = "8.0.27"
  identifier     = "${var.tool}-${var.project}-${var.environment}-mysql"
  username       = "admin"
  password       = random_string.db_password.result
  instance_class = "db.t2.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  multi_az               = false
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = false
  port                   = 3306

  name                 = "${var.project}_db"
  parameter_group_name = aws_db_parameter_group.mysql_parametergroup.name

  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:06:00"
  auto_minor_version_upgrade = false

  deletion_protection = false
  skip_final_snapshot = true
  apply_immediately   = true

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-mysql"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.address
}