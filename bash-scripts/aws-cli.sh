#!/bin/bash
#: Title         : aws-cli 
#: Description   : This script installs aws cli tool 
#: Options       : None
#: Assumptions   : None
sudo yum install -y unzip wget curl vim
cd /tmp
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# Retrieve Name from Instance Tag
REGION="us-east-1"
AWS_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
EC2_NAME=$(aws ec2 describe-tags --region ${REGION} --filters "Name=resource-id,Values=${AWS_INSTANCE_ID}" "Name=key,Values=Name" --output text | cut -f5)
