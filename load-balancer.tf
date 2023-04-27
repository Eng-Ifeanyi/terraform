# create application load balancer
# terraform aws create application load balancer
resource "aws_lb" "application_load_balancer" { 
  name               = "Taste-of-Nigeria"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet_az1.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet_az2.id
  }

  enable_deletion_protection = false

  tags   = {
    Name = "dev-app-load-balancerr"
  }
}

# create target group
# terraform aws create target group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "alb-TG"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200,301,302"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

# create a listener on port 80 with redirect action
# terraform aws create listener
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward" #if using 443, ssl certification, there will be redirect action here for your certification 
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
