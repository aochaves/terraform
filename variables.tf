variable "ami_id" {
  description = "O ID da AMI para a instância"
  type        = string
  default     = "ami-0b6c6ebed2801a5cb"
}

variable "instance_type" {
  description = "O tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}
