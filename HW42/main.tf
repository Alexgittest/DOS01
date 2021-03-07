provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "/root/.aws/credentials "
}

resource "aws_instance" "nginx"{
    ami = "ami-042e8287309f5df03"
    instance_type="t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
    key_name="HW39"
    user_data = <<EOF
#!/bin/bash
apt update -y
apt install -y nginx
EOF
}

resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow HTTP inbound traffic"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from any"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from any"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["46.53.248.211/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}


