terraform {
  backend "s3" {
    bucket = "terraform-state-remote-task"
    key    = "remote-state/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "private_s3_bucket_a" {
  source = "./modules/s3"
  for_each = var.buckets_names   

  bucket_name = each.value
  bucket_acl = "private"
  bucket_s3_tag = {
    "Name" = "my-tf-bucket-tag"
  }
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  bucket_versioning = "Disabled"
}

module "lambda_s3" {
  source = "./modules/lambda"
  lambda_policy_name = "my_lambda_policy_name"
  iam_for_lambda = "own-iam-rules-for-lambda"
  lambda_function_name = "my-tf-lambda-function"
  lambda_handler = "lambda_s3.lambda_handler"
  lambda_runtime = "python3.8"
  lambda_file_type = "zip"
  lambda_source_file_path = "lambda_s3.py"
  lambda_outputh_path = "outputs/lambda_s3.zip"
}




