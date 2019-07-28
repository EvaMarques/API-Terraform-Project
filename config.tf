provider "aws" {
    region = "eu-west-2"
}

resource "aws_s3_bucket" "var_lambda_code" {
  bucket = "lambda-code-bucket"
  acl    = "private"
}

resource "aws_lambda_function" "random_numbers_lambda" {
    function_name = "random_numbers_lambda"
    handler = "lambda.handler"
    filename = "function.zip"
}

data "aws_api_gateway_rest_api" "my_rest_api" {
  name = "my-rest-api"
}

data "aws_api_gateway_resource" "my_resource" {
  rest_api_id = "${data.aws_api_gateway_rest_api.my_rest_api.id}"
  path        = "/api/generate"
}