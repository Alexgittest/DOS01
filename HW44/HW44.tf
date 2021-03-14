terraform {
  backend "s3" {
    bucket = "myawss3-db"
    shared_credentials_file   = "/root/.aws/credentials"
    region = "us-east-1"
    key = "tfstate/terraform.tfstate"
  }
}

provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "/root/.aws/credentials "
}

locals {
  target = "Test for HW44"
  owner  = "Aleksandr Korol"
}


resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow HTTP inbound traffic"
  
  dynamic "ingress" {
    for_each = lookup(var.list_ports,"dev")
      content {
        description = (ingress.value =="443" ? "HTTPS from any" : "HTTP from any") #condition
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    description = "SSH from any"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["46.53.250.98/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_ssh"
    Owner = local.owner
    Target = local.target
  }
}

output "security_group_id"{
  value=aws_security_group.allow_http_ssh.id
}

# resource "aws_instance" "nginx"{
#     ami = "ami-042e8287309f5df03"
#     instance_type="t2.micro"
#     vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
#     key_name="HW39"
#     user_data = <<EOF
# #!/bin/bash
# apt update -y
# apt install -y nginx
# EOF
# }

