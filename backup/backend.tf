# # my account
terraform {
  backend "s3" {
    bucket         = "ta-terraform-tfstates-1"
    key            = "projects/group2/backend/elk-miko-rep/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}

# terraform {
#   backend "s3" {
#     bucket         = "group-2-elk-4073724601872"
#     key            = "group-2-elk/TASK_MIKO/terraform.tfstates"
#     dynamodb_table = "terraform-lock"
#   }
# }

# # group_2 common backend
# terraform {
#   backend "s3" {
#     bucket         = "group-2-elk-4073724601872"
#     key            = "group-2-elk/backend/terraform.tfstates"
#     dynamodb_table = "terraform-lock"
#   }
# }