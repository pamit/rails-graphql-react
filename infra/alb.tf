# ALB for Rails API
resource "aws_security_group" "rails_api_alb_sg" {
  name        = "rails-alb-sg"
  description = "Allow HTTP access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.react_app_alb_sg.id] # Only allow from React ALB SG
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Seems required for public access!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "rails_api_alb" {
  name               = "rails-api-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.rails_api_alb_sg.id]
  subnets            = data.aws_subnets.default.ids
}

resource "aws_lb_target_group" "rails_api_target_group" {
  name     = "rails-api-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "rails_api_listener" {
  load_balancer_arn = aws_lb.rails_api_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rails_api_target_group.arn
  }
}

# ALB for React App
resource "aws_security_group" "react_app_alb_sg" {
  name        = "react-alb-sg"
  description = "Allow HTTP access to React ALB"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "react_app_alb" {
  name               = "react-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.react_app_alb_sg.id]
  subnets            = data.aws_subnets.default.ids
}

resource "aws_lb_target_group" "react_app_target_group" {
  name        = "react-app-tg"
  port        = 3001
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "react_app_listener" {
  load_balancer_arn = aws_lb.react_app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.react_app_target_group.arn
  }
}
