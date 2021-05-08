#!/bin/bash

LAUNCH_TEMPLATE_NAME=my-second-template-for-auto-scaling
LB_name=my-second-load-balancer
TG_NAME=my-second-target-group

#Создание launch-template

aws ec2 create-launch-template --launch-template-name $LAUNCH_TEMPLATE_NAME --version-description version1 \
  --launch-template-data '{"ImageId":"ami-03d315ad33b9d49c4","InstanceType":"t2.micro","SecurityGroupIds":["sg-076329954bcf52d1a"],"KeyName":"HW39"}'
  
  
  
#Создание load-balancer
  
aws elbv2 create-load-balancer --name $LB_name --subnets subnet-e3ba15c2 subnet-b60d7dfb --security-groups sg-0acd137750f9fe6e0

LB_ARN=`aws elbv2 describe-load-balancers --name $LB_name | grep LoadBalancerArn | cut -d ":" -f 2- | tr -d "\"," `

#Создание target-group для балансировки

aws elbv2 create-target-group --name $TG_NAME --protocol HTTP --port 80 --vpc-id vpc-e115e89c \
--health-check-protocol HTTP  --health-check-port 80 --target-type instance

#Создание listener для балансировщика

TG_ARN=`aws elbv2 describe-target-groups --names $TG_NAME | grep TargetGroupArn | cut -d ":" -f 2- | tr -d "\","`

aws elbv2  create-listener --load-balancer-arn $LB_ARN \
--protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn="$TG_ARN"

#Создание auto-scaling группы

aws autoscaling create-auto-scaling-group --auto-scaling-group-name ASG2 --launch-template LaunchTemplateName=$LAUNCH_TEMPLATE_NAME --min-size 0 --max-size 2 --desired-capacity 0 \
--availability-zones us-east-1a us-east-1b --target-group-arns $TG_ARN




LB_ARN_part1=`aws elbv2 describe-load-balancers --names my-second-load-balancer | grep loadbalancer | awk -Fapp '{print $2}' | tr -d "\","`

TG_ARN_part1=`aws elbv2 describe-target-groups --names my-second-target-group | grep targetgroup | awk -Ftargetgroup '{print $2}' | tr -d "\","`

Resource_LABEL=app$LB_ARN_part1/targetgroup$TG_ARN_part1


aws autoscaling put-scaling-policy --auto-scaling-group-name ASG2 --policy-name ASG2-policy1 --policy-type TargetTrackingScaling \
--target-tracking-configuration '{"TargetValue": 50,"PredefinedMetricSpecification":'\
'{"PredefinedMetricType": "ALBRequestCountPerTarget",'\
'"ResourceLabel": "'$Resource_LABEL'"}}'



