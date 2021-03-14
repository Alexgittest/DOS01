provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "/root/.aws/credentials "
}

resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "vpc-0bf62cd63cb936f50"

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
  }
}


resource "aws_launch_template" "Aleks_template" {
  name = "Aleks_template"
  image_id="ami-03d315ad33b9d49c4"
  instance_type= "t2.micro"
  key_name="HW39"
 # security_group_names=["allow_http_ssh"]
  vpc_security_group_ids=[aws_security_group.allow_http_ssh.id]
  user_data = filebase64("./user_data.sh")
}

resource "aws_lb" "lb1" {
  name               = "terraform-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_ssh.id]
  subnets            = ["subnet-032dc5a3b4118b8ea","subnet-05c914e5b4a01a563"]

}

resource "aws_lb_target_group" "tg1" {
  name     = "target-group-for-lb1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0bf62cd63cb936f50"
  target_type = "instance"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
}

resource "aws_autoscaling_group" "ASG1" {
  name                      = "auto-scaling-group1"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.tg1.arn]
  launch_template{
   name  = aws_launch_template.Aleks_template.name
  }           
  vpc_zone_identifier       = ["subnet-032dc5a3b4118b8ea","subnet-05c914e5b4a01a563"]

  depends_on = [
    aws_lb_target_group.tg1,aws_lb_listener.front_end,aws_lb.lb1,
  ]
}

resource "aws_autoscaling_policy" "policy1" {
  name                   = "policy1"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.ASG1.name

  target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ALBRequestCountPerTarget"
        resource_label = join("/", ["app/terraform-lb",split("/",aws_lb.lb1.arn)[3],"targetgroup/target-group-for-lb1",split("/",aws_lb_target_group.tg1.arn)[2]])
      }
      target_value = 50
    }

    depends_on = [
    aws_lb_target_group.tg1,aws_lb_listener.front_end,aws_lb.lb1,
  ]

}

