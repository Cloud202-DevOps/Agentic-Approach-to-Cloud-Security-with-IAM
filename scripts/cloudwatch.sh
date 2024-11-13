#!/bin/bash

# Variables
ALARM_NAME="IAMPolicyChangeAlarm"
TOPIC_NAME="IAMAlerts"
LOG_GROUP_NAME="IAMChanges"
ALARM_EMAIL="your-email@example.com"

# Create SNS Topic
TOPIC_ARN=$(aws sns create-topic --name $TOPIC_NAME --query 'TopicArn' --output text)
aws sns subscribe --topic-arn $TOPIC_ARN --protocol email --notification-endpoint $ALARM_EMAIL

# Enable CloudTrail
aws cloudtrail create-trail --name IAMTrail --s3-bucket-name cloudtrail-bucket
aws cloudtrail start-logging --name IAMTrail

# Create Log Group if it doesn't exist
if ! aws logs describe-log-groups --log-group-name-prefix $LOG_GROUP_NAME | grep $LOG_GROUP_NAME; then
  aws logs create-log-group --log-group-name $LOG_GROUP_NAME
fi

# Create Metric Filter for IAM Policy Changes
aws logs put-metric-filter --log-group-name $LOG_GROUP_NAME --filter-name IAMPolicyChangesFilter --metric-transformations metricName=IAMPolicyChanges,metricNamespace=IAM,metricValue=1 --filter-pattern '{ ($.eventName = "PutUserPolicy") || ($.eventName = "DeleteUserPolicy") || ($.eventName = "AttachUserPolicy") || ($.eventName = "DetachUserPolicy") }'

# Create Alarm
aws cloudwatch put-metric-alarm --alarm-name $ALARM_NAME --metric-name IAMPolicyChanges --namespace IAM --statistic Sum --period 300 --threshold 1 --comparison-operator GreaterThanOrEqualToThreshold --evaluation-periods 1 --alarm-actions $TOPIC_ARN

echo "CloudWatch alarm for IAM policy changes set up. Check your email for SNS subscription confirmation."
