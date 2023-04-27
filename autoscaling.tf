# create a launch template
# terraform aws launch template
resource "aws_launch_template" "webserver_launch_template" {
  name          = var.launch-template_name
  image_id      = var.ec2_image_id
  instance_type = var.instance_type
  key_name      = var.ec2_key_name
  description   = "launch template for autoscaling group"

  monitoring {
    enabled = false
  }

  vpc_security_group_ids = [aws_security_group.web-sg.id]
  user_data = base64encode(<<EOF
                #!/bin/bash
                sudo su
                yum update -y
                yum install -y httpd
                mkdir website-folder
                cd website-folder/
                wget https://github.com/Eng-Ifeanyi/website-deployment-ec2/archive/refs/heads/master.zip
                unzip master.zip
                cd website-deployment-ec2-master/
                mv * /var/www/html/
                cd /var/www/html/
                systemctl enable httpd
                systemctl start httpd
                systemctl status httpd
                EOF
    )

}

# create auto scaling group
# terraform aws autoscaling group
resource "aws_autoscaling_group" "auto_scaling_group" {
  vpc_zone_identifier = [aws_subnet.private_app_subnet_az1.id, aws_subnet.private_app_subnet_az2.id]
  desired_capacity    = 2 #number of servers to deploy
  max_size            = 4 #number of servers to deploy during peak hours
  min_size            = 1 #number of servers to deploy when demand is low
  name                = "dev-ASG"
  health_check_type   = "ELB"

  launch_template {
    name    = aws_launch_template.webserver_launch_template.name
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ASG-Webserver"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes      = [target_group_arns] # or ==>["target_group_arn"]?
  }
}

# attach auto scaling group to alb target group
# terraform aws autoscaling attachment
resource "aws_autoscaling_attachment" "asg_alb_target_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.id
  lb_target_group_arn    = aws_lb_target_group.alb_target_group.arn
}
