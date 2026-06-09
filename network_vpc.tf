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

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Route Table Pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associação da Route Table à Subnet A
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# Associação da Route Table à Subnet B
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
