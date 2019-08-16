provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "var_lambda_code" {
  bucket = "lambda-code-bucket280720191630"
  acl    = "private"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
	"Action": "sts:AssumeRole",
	"Principal": {
	  "Service": "lambda.amazonaws.com"
	},
	"Effect": "Allow",
	"Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_lambda_function" "random_numbers_lambda" {
  function_name = "random_numbers_lambda"
  handler = "lambda.lambda_handler"
  role = "${aws_iam_role.iam_for_lambda.arn}"
  s3_bucket = "${aws_s3_bucket.var_lambda_code.bucket}"
  s3_key = "function.zip"
  runtime = "python2.7"
}

resource "aws_api_gateway_rest_api" "MyDemoAPI" {
  name        = "my-rest-api"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "MyDemoResource" {
  rest_api_id = "${aws_api_gateway_rest_api.MyDemoAPI.id}"
  parent_id   = "${aws_api_gateway_rest_api.MyDemoAPI.root_resource_id}"
  path_part   = "mydemoresource"
}
