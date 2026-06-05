# VPC Principal
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default" # default (uso compartilhado) dedicate (uso exclusivo)
  tags = { 
    Name = "vpc-trabalho" 
  }
}

# Sub-rede Pública - Zone A
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id #associa com a VPC Principal
  cidr_block        = "10.0.1.0/24"   # Define o intervalo de IPs de cada sub-rede
  availability_zone = "us-east-1a" # cada sub-rede ficara emm um data center fisicamente separado (Zone A e Zone B)
  map_public_ip_on_launch = true  # garante que recebam um IP publico
  tags = { 
    Name = "Public-Subnet-A" 
  }
}

# Sub-rede Pública - Zone B
resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { 
    Name = "Public-Subnet-B" 
  }
}
