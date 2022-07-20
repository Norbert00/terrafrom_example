resource "aws_iam_role_policy" "lambda_policy" {
  name = var.lambda_policy_name
  assume_role_policy = aws_iam_role.iam_for_lambda.id
  # policy = <<EOF
  # {
  #   "Version": "2012-10-17",
  #   "Statement": [
  #     {
  #       "Action": [
  #         "s3:ListBucket",
  #         "s3:GetObject",
  #         "s3:CopyObject",
  #         "s3:HeadObject"
  #       ],
  #       "Effect": "Allow",
  #       "Resource": [
  #         "arn:aws:s3:::${var.bucket_name}-src-bucket",
  #         "arn:aws:s3:::${var.bucket_name}-src-bucket/*"
  #       ]
  #     },
  #     {
  #       "Action": [
  #         "s3:ListBucket",
  #         "s3:PutObject",
  #         "s3:PutObjectAcl",
  #         "s3:CopyObject",
  #         "s3:HeadObject"
  #       ],
  #       "Effect": "Allow",
  #       "Resource": [
  #         "arn:aws:s3:::${var.bucket_name}-dst-bucket",
  #         "arn:aws:s3:::${var.bucket_name}-dst-bucket/*"
  #       ]
  #     },
  #     {
  #       "Action": [
  #         "logs:CreateLogGroup",
  #         "logs:CreateLogStream",
  #         "logs:PutLogEvents"
  #       ],
  #       "Effect": "Allow",
  #       "Resource": "*"
  #     }
  #   ]
  # }
  # EOF
}

resource "aws_iam_role" "iam_for_lambda" {
  name = var.iam_for_lambda
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


resource "aws_lambda_function" "test_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.lambda_handler
  runtime = var.lambda_runtime
}

data "archive_file" "init" {
  type        = var.lambda_file_type
  source_file = var.lambda_source_file_path
  output_path = var.lambda_outputh_path
}
