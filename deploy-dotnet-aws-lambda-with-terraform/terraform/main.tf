terraform {
  backend "s3" {
    bucket         = "cwm-tf-states"
    key            = "deploy-dotnet-aws-lambda-with-terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "cwm-state-locks"
    encrypt        = true
  }
}
