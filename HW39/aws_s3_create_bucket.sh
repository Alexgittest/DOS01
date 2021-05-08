#!/bin/bash

aws s3 mb s3://aleksandr-s3-test
 
aws s3 cp S3.png s3://aleksandr-s3-test

aws s3api put-bucket-acl --bucket aleksandr-s3-test  --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers

aws s3api put-object-acl --bucket aleksandr-s3-test --key S3.png  --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers
