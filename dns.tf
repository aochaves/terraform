# 1. Definição da Zona Hospedada
resource "aws_route53_zone" "primary" {
  name = "exemplo.com"
}

# 2. Registro DNS (Alias) apontando para o Load Balancer
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.exemplo.com"
  type    = "A"
  alias {
    name                   = aws_lb.app_alb.dns_name # Nome DNS do ALB
    zone_id                = aws_lb.app_alb.zone_id # ID da zona do ALB
    evaluate_target_health = true # permite que o Route 53 verifique se o balanceador está saudável antes de direcionar o tráfego
  }
}
