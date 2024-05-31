#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 6 ]; then
  echo "Usage: $0 <BUCKET_NAME> <TABLE_NAME> <READ_CAPACITY_UNITS> <WRITE_CAPACITY_UNITS> <ENV> <PROJECT>"
  exit 1
fi

BUCKET_NAME="$1"
TABLE_NAME="$2"
READ_CAPACITY_UNITS="$3"
WRITE_CAPACITY_UNITS="$4"
ENV="$5"
PROJECT="$6"

# Check if S3 bucket exists, create if not
if ! aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo "Bucket does not exist. Creating bucket..."
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME"
  echo "Bucket created successfully."

  # Add tags to the S3 bucket
  aws s3api put-bucket-tagging \
    --bucket "$BUCKET_NAME" \
    --tagging 'TagSet=[{Key="Env",Value="'$ENV'"},{Key="Project",Value="'$PROJECT'"}]'
  echo "Tags added to the bucket."
else
  echo "Bucket '$BUCKET_NAME' already exists."
fi

# Check if DynamoDB table exists, create if not
if ! aws dynamodb describe-table --table-name "$TABLE_NAME" 2>/dev/null; then
  echo "Table does not exist. Creating table..."
  aws dynamodb create-table \
    --table-name "$TABLE_NAME" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
	--tags '[{"Key":"Env","Value":"'$ENV'"},{"Key":"Project","Value":"'$PROJECT'"}]'
  echo "Table created successfully."
else
  echo "Table '$TABLE_NAME' already exists."
fi
