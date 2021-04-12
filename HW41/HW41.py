#!/usr/bin/python3.8

import boto3

client = boto3.client('ec2',region_name='us-east-2')

response = client.copy_image(
    Name='Aleksandr_Korol_AMI',
    SourceImageId='ami-04197737ba95d5afd',
    SourceRegion='us-east-1',
)

print(response)


