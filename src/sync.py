import logging

# import boto3
import os

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    logger.info("Listing contents of S3 bucket")
    bucket_name = os.environ["S3_BUCKET_NAME"]
    print(bucket_name)

    logger.info("Listing buckets complete")
