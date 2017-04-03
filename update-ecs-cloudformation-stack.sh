#!/usr/bin/env bash
set -e

echo "In configure-ecs.sh"

MY_STACK=$1
MY_DOCKERHUB_REPO=$2
DOCKER_USER_NAME=$3
DOCKER_PASS=$4
CF_TEMPLATE_URL=$5
IMAGE_TAG=$6

echo The value of arg 0 = $0
echo The value of arg MY_STACK = $MY_STACK
echo The value of arg MY_DOCKERHUB_REPO = $MY_DOCKERHUB_REPO  
echo The value of DOCKER_USER_NAME = $DOCKER_USER_NAME  
echo The value of DOCKER_PASS = $DOCKER_PASS
echo The value of CF_TEMPLATE_URL = $CF_TEMPLATE_URL
echo The value of IMAGE_TAG = $IMAGE_TAG

dockerhub_repo="$MY_DOCKERHUB_REPO"
ecs_stack_name="$MY_STACK"
ecs_template_url="$CF_TEMPLATE_URL"


# Build, Tag and Deploy Docker
docker build -t $dockerhub_repo:$IMAGE_TAG .
docker login --username=$DOCKER_USER_NAME --password=$DOCKER_PASS
docker push $dockerhub_repo

aws cloudformation update-stack --stack-name $ecs_stack_name --template-url $ecs_template_url --region us-east-1 --capabilities="CAPABILITY_IAM" --parameters ParameterKey=AppContext,UsePreviousValue=true ParameterKey=ClusterName,UsePreviousValue=true ParameterKey=ContainerName,UsePreviousValue=true ParameterKey=ContainerPort,UsePreviousValue=true ParameterKey=DesiredCapacity,UsePreviousValue=true ParameterKey=ECSRepoName,UsePreviousValue=true ParameterKey=HostPort,UsePreviousValue=true ParameterKey=ImageTag,ParameterValue=$IMAGE_TAG ParameterKey=InstanceType,UsePreviousValue=true ParameterKey=KeyName,UsePreviousValue=true ParameterKey=MaxSize,UsePreviousValue=true ParameterKey=DesiredCount,UsePreviousValue=true ParameterKey=MaxPercent,UsePreviousValue=true ParameterKey=MinHealthyPercent,UsePreviousValue=true 

sleep 10
