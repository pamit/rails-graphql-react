resource "aws_ecs_cluster" "main" {
  name = "my-blog-app-cluster"
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

# ECS Task Definitions
resource "aws_ecs_task_definition" "rails_api" {
  family                   = "my-blog-api-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256" # 256=0.25vCPU
  memory                   = "512" # 512=0.5GB
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "my-blog-api"
    image     = "${aws_ecrpublic_repository.rails_api.repository_uri}:latest"
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
    environment = [
      {
        name  = "RAILS_ENV"
        value = "development"
      }
    ]
  }])
}

resource "aws_ecs_task_definition" "react_app" {
  family                   = "my-blog-app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "1024" # 1vCPU
  memory                   = "3072" # 3GB
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "my-blog-app"
    image     = "${aws_ecrpublic_repository.react_app.repository_uri}:latest"
    essential = true
    portMappings = [{
      containerPort = 3001
      hostPort      = 3001
    }]
    environment = [
      {
        name  = "REACT_APP_API_URL"
        value = "http://my-blog-api-service:3000/graphql"
      }
    ]
  }])
}

# ECS Service
resource "aws_ecs_service" "rails_api" {
  name            = "my-blog-api-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.rails_api.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [data.aws_security_group.default.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_service" "react_app" {
  name            = "my-blog-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.react_app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [data.aws_security_group.default.id]
    assign_public_ip = true
  }
}
