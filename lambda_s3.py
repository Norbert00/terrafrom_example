import json
import boto3
import os
s3_client=boto3.client('s3')

def lambda_handler(event, context):
    source_bucket_name=event['Records'][0]['s3']['bucket']['name']
    file_name=event['Records'][0]['s3']['object']['key']
    # Bucket name is taken from DESTINATION_BUCKET environment variable
    destination_bucket_name=os.environ.get('DESTINATION_BUCKET')
    s3_client.copy_object(CopySource={'Bucket':source_bucket_name,'Key':file_name}, Bucket=destination_bucket_name, Key=file_name)