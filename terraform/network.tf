# -------------------------------------------
# VPC
# -------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-vpc"
  }
}

# -------------------------------------------
# Subnet (マルチAZ)
# -------------------------------------------
### ECS用サブネット
resource "aws_subnet" "ecs_public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-ecs-public-subnet-1a"
  }
}

resource "aws_subnet" "ecs_public_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-ecs-public-subnet-1c"
  }
}

### DB用サブネット
resource "aws_subnet" "db_private_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-db-private-subnet-1a"
  }
}

resource "aws_subnet" "db_private_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.12.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-db-private-subnet-1c"
  }
}

# -------------------------------------------
# InternetGateway
# -------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-igw"
  }
}

# -------------------------------------------
# RootTable
# -------------------------------------------
### Public
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-public-rt"
  }
}

# Publicには、インターネットゲートウェイに繋がるルートを追加する
resource "aws_route" "public_rt_igw_r" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "ecs_public_rt_1a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.ecs_public_subnet_1a.id
}
resource "aws_route_table_association" "ecs_public_rt_1c" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.ecs_public_subnet_1c.id
}

### Private
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.tool}-${var.project}-${var.environment}-private-rt"
  }
}

resource "aws_route_table_association" "db_private_rt_1a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.db_private_subnet_1a.id
}
resource "aws_route_table_association" "db_private_rt_1c" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.db_private_subnet_1c.id
}