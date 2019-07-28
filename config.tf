provider "aws" {
    region = "eu-west-2"
}

resource "aws_s3_bucket" "var_lambda_code" {
  bucket = "lambda-code-bucket"
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
	s3_bucket = "lambda-code-bucket"
    s3_key = "function.zip"
	runtime = "python2.7"
}

data "aws_api_gateway_rest_api" "my_rest_api" {
  name = "my-rest-api"
}

data "aws_api_gateway_resource" "my_resource" {
  rest_api_id = "${data.aws_api_gateway_rest_api.my_rest_api.id}"
  path        = "/api/generate"
}
