output "hello_api_url" {
  value = aws_lambda_function_url.hello_api_url.function_url
}
