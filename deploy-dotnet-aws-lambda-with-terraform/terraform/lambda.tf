## Archiving the Artifacts
data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "../HelloAPI/publish/"
  output_path = "./hello_api.zip"
  depends_on  = [null_resource.build_dotnet_lambda]
}

## IAM Permissions and Roles related to Lambda
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "hello_api_role" {
  name               = "hello_api_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

## AWS Lambda Resources
resource "aws_lambda_function" "hello_api" {
  filename         = "hello_api.zip"
  function_name    = "hello_api"
  role             = aws_iam_role.hello_api_role.arn
  handler          = "HelloAPI"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "dotnet8"
  depends_on       = [data.archive_file.lambda]
  environment {
    variables = {
      ASPNETCORE_ENVIRONMENT = "Development"
    }
  }
}

resource "aws_lambda_function_url" "hello_api_url" {
  function_name      = aws_lambda_function.hello_api.function_name
  authorization_type = "NONE"
}
