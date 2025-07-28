resource "aws_ecs_cluster" "main" {
  name = "my-blog-app-cluster"
}

# ECS Task Definitions
resource "aws_ecs_task_definition" "rails_api" {
  family                   = "my-blog-api-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256" # 256=0.25vCPU
  memory                   = "512" # 512=0.5GB
  execution_role_arn       = aws_iam_role.ecs_task_execution_role_for_blog_app.arn
  # execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

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
  execution_role_arn       = aws_iam_role.ecs_task_execution_role_for_blog_app.arn
  # execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

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
        value = "http://${aws_lb.rails_api_alb.dns_name}/graphql"
        # value = "http://my-blog-api-service:3000/graphql"
      }
    ]
  }])
}

# ECS Service
resource "aws_security_group" "ecs_service_sg" {
  name   = "rails-api-ecs-service-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "rails_api" {
  name            = "my-blog-api-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.rails_api.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_service_sg.id]
    # security_groups  = [data.aws_security_group.default.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.rails_api_target_group.arn
    container_name   = "my-blog-api"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.rails_api_listener]
}

resource "aws_ecs_service" "react_app" {
  name            = "my-blog-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.react_app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_service_sg.id]
    # security_groups  = [data.aws_security_group.default.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.react_app_target_group.arn
    container_name   = "my-blog-app"
    container_port   = 3001
  }

  depends_on = [aws_lb_listener.react_app_listener]
}
