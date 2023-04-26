#variable for ami
variable "ami_id" {
    description = "The ami for my ec2 instance"
}

#variable for instance type
variable "instance_type" {
    description = "my instance type"
}

#variable for ec2 tag
variable "instance-name" {
  description = "my instance tag name"
}