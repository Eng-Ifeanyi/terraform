#vpc variables
variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "vpc cidr block"
    type = string
}

#public subnet AZ1
variable "public_subnet_AZ1_cidr" {
    default = "10.0.0.0/24"
    description = "vpc cidr block"
    type = string
}

#public subnet AZ2
variable "public_subnet_AZ2_cidr" {
    default = "10.0.1.0/24"
    description = "vpc cidr block"
    type = string
}

#private subnet AZ1
variable "private_App_subnet_AZ1_cidr" {
    default = "10.0.2.0/24"
    description = "vpc cidr block"
    type = string
}

#private subnet AZ2
variable "private_App_subnet_AZ2_cidr" {
    default = "10.0.3.0/24"
    description = "vpc cidr block"
    type = string
}

#launch template variable
variable "launch-template_name" {
    default = "dev-launch-template"
    description = "launch template var"
    type = string
}

#image id variable
variable "ec2_image_id" {
    default = "ami-02d5619017b3e5162"
    description = "ec2 image id"
    type = string
}

#instance type variable
variable "instance_type" {
    default = "t2.micro"
    description = "instance type"
    type = string
}

#key-pair name variable
variable "ec2_key_name" {
    default = "webserver-key"
    description = "ec2 instance key-pair name"
    type = string
}