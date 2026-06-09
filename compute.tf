# Modelo de Maquina com o AMI e o tipo o
resource "aws_launch_template" "app_config" {
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "<h1>Servidor funcionando</h1>" > /var/www/html/index.html
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "WebServer-ASG"
    }
  }
}

# Grupo de Auto Scaling
resource "aws_autoscaling_group" "app_asg" {
  # Define onde as instâncias serão lançadas (Zonas A e B)
  vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  
  # Capacidade desejada e limites
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.app_tg.arn]

  launch_template {
    id      = aws_launch_template.app_config.id
    version = "$Latest"
  }
}

# definir o crescimento de 80%
resource "aws_autoscaling_policy" "cpu_target" {
  name                   = "cpu-target"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80
  }
}
