#!/usr/bin/python3.8

import boto3
import time
import datetime
from dateutil.tz import tzutc


s3_bucket=os.environ["S3_BUCKET"]
iam_role=os.environ["IAM_ROLE"]
kms_key=os.eviron["KMS_KEY"]



client = boto3.client('rds',region_name='us-east-1')

response = client.create_db_snapshot(
    DBSnapshotIdentifier='sn3',
    DBInstanceIdentifier='database-1'
)

snapshot_arn=response['DBSnapshot']['DBSnapshotArn']
print(snapshot_arn)


time.sleep(240)


response = client.start_export_task(
    ExportTaskIdentifier='db-backup-to-s3',
    SourceArn=snapshot_arn,
    S3BucketName=s3_bucket,
    IamRoleArn=iam_role,
    KmsKeyId=kms_key,
    ExportOnly=[
        'mysql.plugin'
    ]
)

