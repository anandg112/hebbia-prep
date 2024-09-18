module "sync_lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "sync-lambda"
  description   = "My sync lambda function"
  handler       = "sync.lambda_handler"
  runtime       = "python3.12"

  source_path = "../src"

  tags = {
    Name  = "sync-function"
    Owner = "Hebbia"
    Team  = "Platform"
  }

  create_role = false
  lambda_role = module.s3_role.arn

  environment_variables = {
    S3_BUCKET_NAME = "tf-state-anand"
  }

  depends_on = [module.s3_role]
}




