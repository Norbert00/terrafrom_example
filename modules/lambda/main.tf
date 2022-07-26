resource "aws_iam_role" "iam_for_lambda" {
  name = var.iam_for_lambda
  assume_role_policy =<<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": "test"
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
  filename = data.archive_file.init.output_path

    environment {
    variables = {
      DESTINATION_BUCKET = "tf-bucket-test-b"
    }
  }

}

data "archive_file" "init" {
  type        = var.lambda_file_type
  source_file = var.lambda_source_file_path
  output_path = var.lambda_outputh_path
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
bucket = aws_s3_bucket.bucket.id
lambda_function {
lambda_function_arn = aws_lambda_function.test_lambda.arn
events              = ["s3:ObjectCreated:*"]
filter_prefix       = "file-prefix"
filter_suffix       = "file-extension"
}
}

