output "rails_api_alb_url" {
  value = "http://${aws_lb.rails_api_alb.dns_name}"
}

output "react_app_alb_url" {
  value = "http://${aws_lb.react_app_alb.dns_name}"
}
