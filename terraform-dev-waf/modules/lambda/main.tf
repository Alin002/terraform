terraform {
    required_version = ">= 0.14"
    }
    
provider "aws" {
    region = "eu-west-1"
}

resource "aws_iam_role_policy" "lambda_policy" {
    name   = "lambda_policy"
    role   = aws_iam_role.lambda_role.id
    policy = file("../modules/lambda//IAM/lambda_policy.json")
}
resource "aws_iam_role" "lambda_role" {
    name               = "lambda_role"
    assume_role_policy = file("../modules/lambda//IAM/lambda_assume_role_policy.json")
}

data "archive_file" "hellolambda" {
    type        = "zip"
    source_file = "helloworld.py"
    output_path = "helloworld.zip"
}

resource "aws_lambda_function" "test_lambda" {

    function_name = "helloworld"
    filename      = "helloworld.zip"
#    s3_bucket     = "forlambda123"
#    s3_key        = "helloworld.zip"
    role          = aws_iam_role.lambda_role.arn
    handler       = "helloworld.lambda_handler"

    source_code_hash = "filebase64sha256(helloworld.zip)"
    runtime       = "python3.8"
# runtime       = "nodejs12.x"
}