# 1. create backend bucket on s3 
# usually you will import the bucket data if a bucket exists, not create a new bucket

# 2. initiate tf and apply to create the lock table locally
# lock on main.tf resource "aws_dynamodb_table" "terraform_lock_tbl" will create a lock locally 
# created aws_dynamodb_table.terraform_lock_tbl
# Terraform has created a lock file .terraform.lock.hcl to record the provider selections it made above. Include this file in your version control repository so that Terraform can guarantee to make the same selections by default when you run "terraform init" in the future.

# terraform init -reconfigure
# copy existing state to the new backend
# - migrating the previous "local" backend to the newly configured "s3" backend
# - copy this state to the new "s3" backend? Enter "yes"

resource "aws_s3_bucket" "backend_bucket" {
  bucket = "ta-terraform-tfstates-1"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "ta-terraform-tfstates-1"
    Environment = "Test"
    Team        = "Miko-individual"
    Owner       = "Miko"
  }
}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
  bucket = aws_s3_bucket.backend_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock_tbl" {
  name           = "terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-lock"
  }
}