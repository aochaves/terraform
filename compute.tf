# Modelo de Maquina com o AMI e o tipo o
resource "aws_launch_template" "app_config" {
  image_id      = "ami-0b6c6ebed2801a5cb"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
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
