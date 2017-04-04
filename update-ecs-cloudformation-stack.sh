#!/usr/bin/env bash
set -e

echo "In update-ecs-cloudformation-stack.sh"

MY_STACK=$1
CF_TEMPLATE_URL=$2
IMAGE_TAG=$3

echo The value of arg MY_STACK = $MY_STACK
echo The value of CF_TEMPLATE_URL = $CF_TEMPLATE_URL
echo The value of IMAGE_TAG = $IMAGE_TAG

ecs_stack_name="$MY_STACK"
ecs_template_url="$CF_TEMPLATE_URL"


aws cloudformation update-stack --stack-name $ecs_stack_name --template-url $ecs_template_url --region us-east-1 --capabilities="CAPABILITY_IAM" --parameters ParameterKey=AppContext,UsePreviousValue=true ParameterKey=ClusterName,UsePreviousValue=true ParameterKey=ContainerName,UsePreviousValue=true ParameterKey=ContainerPort,UsePreviousValue=true ParameterKey=DesiredCapacity,UsePreviousValue=true ParameterKey=ECSRepoName,UsePreviousValue=true ParameterKey=HostPort,UsePreviousValue=true ParameterKey=ImageTag,ParameterValue=$IMAGE_TAG ParameterKey=InstanceType,UsePreviousValue=true ParameterKey=KeyName,UsePreviousValue=true ParameterKey=MaxSize,UsePreviousValue=true ParameterKey=DesiredCount,UsePreviousValue=true ParameterKey=MaxPercent,UsePreviousValue=true ParameterKey=MinHealthyPercent,UsePreviousValue=true 

sleep 10
