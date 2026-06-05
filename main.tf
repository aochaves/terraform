terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

output "alb_dns_name" {
  description = "DNS do Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}
