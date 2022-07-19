# -------------------------------------------
# ECS
# -------------------------------------------
### クラスター ###
resource "aws_ecs_cluster" "cluster" {
  name = "${var.tool}-${var.project}-${var.environment}-ecs-application-cluster"
}

### サービス ###
resource "aws_ecs_service" "service" {
  name                              = "${var.tool}-${var.project}-${var.environment}-ecs-application-service"
  cluster                           = aws_ecs_cluster.cluster.arn
  task_definition                   = aws_ecs_task_definition.task_def.arn
  desired_count                     = 1
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 180
  enable_execute_command            = true

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]

    subnets = [
      aws_subnet.ecs_public_subnet_1a.id,
      aws_subnet.ecs_public_subnet_1c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue_tg.arn
    container_name   = "nginx-container"
    container_port   = 80
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  lifecycle {
    ignore_changes = [task_definition, load_balancer]
  }

  depends_on = [aws_db_instance.mysql]
}

### タスク定義 ###
resource "aws_ecs_task_definition" "task_def" {
  family                   = "${var.tool}-${var.project}-${var.environment}-ecs-application-task-def"
  cpu                      = 512
  memory                   = 1024
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
  task_role_arn            = module.ecs_task_role.iam_role_arn

  container_definitions = jsonencode([
    {
      name      = "rails-container"
      image     = aws_ecr_repository.backend.repository_url
      memory    = 512
      essential = true
      logConfiguration = {
        logDriver : "awslogs",
        options : {
          awslogs-region : "ap-northeast-1",
          awslogs-stream-prefix : "backend",
          awslogs-group : aws_cloudwatch_log_group.ecs_backend.name
        }
      },
      secrets = [
        {
          name      = "DB_USERNAME",
          valueFrom = "/container-param/db-username"
        },
        {
          name      = "DB_PASSWORD",
          valueFrom = "/container-param/db-password"
        },
        {
          name      = "DB_HOST",
          valueFrom = "/container-param/db-host"
        }
      ]
    },
    {
      name      = "nginx-container"
      image     = aws_ecr_repository.web.repository_url
      memory    = 512
      essential = true
      logConfiguration = {
        logDriver : "awslogs",
        options : {
          awslogs-region : "ap-northeast-1",
          awslogs-stream-prefix : "web",
          awslogs-group : aws_cloudwatch_log_group.ecs_web.name
        }
      },
      volumesFrom = [
        {
          readonly        = null,
          sourceContainer = "rails-container"
        }
      ]
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

### 1.IAMロール：タスク実行ロール ###
data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters"]
    resources = ["*"]
  }
}

module "ecs_task_execution_role" {
  source     = "./modules/iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}

### 2.IAMロール：タスクロール ###
data "aws_iam_policy_document" "ecs_task" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
}

module "ecs_task_role" {
  source     = "./modules/iam_role"
  name       = "ecs-task"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task.json
}

### 3.IAMロール：CodeDeployロール ###
data "aws_iam_policy" "ecs_code_deploy_role_policy" {
  arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

data "aws_iam_policy_document" "ecs_code_deploy" {
  source_json = data.aws_iam_policy.ecs_code_deploy_role_policy.policy
}

module "ecs_code_deploy_role" {
  source     = "./modules/iam_role"
  name       = "ecs-code-deploy"
  identifier = "codedeploy.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_code_deploy.json
}

### CodeDeploy ###
resource "aws_codedeploy_app" "codedeploy_app" {
  compute_platform = "ECS"
  name             = "${var.tool}-${var.project}-${var.environment}-codedeploy-app"
}

resource "aws_codedeploy_deployment_group" "codedeploy_dg" {
  app_name               = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name  = "${var.tool}-${var.project}-${var.environment}-codedeploy-dg"
  service_role_arn       = module.ecs_code_deploy_role.iam_role_arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.cluster.name
    service_name = aws_ecs_service.service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_lb_listener.https.arn]
      }

      target_group {
        name = aws_lb_target_group.blue_tg.name
      }

      target_group {
        name = aws_lb_target_group.green_tg.name
      }
    }
  }
}

### ECR ###
resource "aws_ecr_repository" "backend" {
  name = "${var.tool}-${var.project}-${var.environment}-backend-rails-repo"
}

resource "aws_ecr_repository" "web" {
  name = "${var.tool}-${var.project}-${var.environment}-web-nginx-repo"
}

### CloudWatch Logs ###
resource "aws_cloudwatch_log_group" "ecs_backend" {
  name              = "/${var.tool}-${var.project}-${var.environment}/ecs/backend"
  retention_in_days = 180
}

resource "aws_cloudwatch_log_group" "ecs_web" {
  name              = "/${var.tool}-${var.project}-${var.environment}/ecs/web"
  retention_in_days = 180
} 