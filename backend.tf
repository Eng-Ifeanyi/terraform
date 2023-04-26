terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-ifeanyi"
    key            = "terraform-state-folder/terraform.tfstate" #folder name, it will check and create one if there is non
    region         = "us-west-2"
    profile = "terraform" #Your AWS IAM username, used to configure AWS CLI 
    dynamodb_table = "dynamodb-table" #To lock state file and prevent code changes happening at the same time and mess up the code/app
  }
}


######This will prevent you from deleting the resource by mistake
#####uncomment this resource to enable this function
# resource "aws_s3_bucket" "s3_bucket" {
#      bucket = "terraform-state-bucket-terraform"
#    lifecycle {
#      prevent_destroy = true
#    }
#     lifecycle {
#      ignore_changes = [
#        #ignore changes to the following attributes ===>ask about this # before the ignore
#      ]
#     }
#  }