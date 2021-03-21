
locals {
  target = "Test for HW44"
  owner  = "Aleksandr Korol"
}


resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = var.sg_description
  
  dynamic "ingress" {
    for_each = var.ports_list
      content {
        description = ingress.value
        from_port   = ingress.key
        to_port     = ingress.key
        protocol    = "tcp"
        cidr_blocks = var.cidr_for_data
    }
  }

  ingress {
    description = "SSH from my pc"
    from_port   = var.port_mng
    to_port     = var.port_mng
    protocol    = "tcp"
    cidr_blocks = var.cidr_for_mng
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tags_list.Name
    Owner = var.tags_list.Owner
    Target = var.tags_list.Target
  }

}

