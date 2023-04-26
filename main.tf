# #Create EC2 Instance
# resource "aws_instance" "example" {
#   ami           = "ami-02d5619017b3e5162"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "instance"
#   }
#     lifecycle {
#         create_before_destroy = true
#   }
# }