#!/bin/bash

# Variables
USER_NAME="NewUser"

# Create a new access key
NEW_ACCESS_KEY=$(aws iam create-access-key --user-name $USER_NAME --query 'AccessKey.[AccessKeyId, SecretAccessKey]' --output text)
echo "New access key created for user $USER_NAME."

# Disable old keys
OLD_KEYS=$(aws iam list-access-keys --user-name $USER_NAME --query 'AccessKeyMetadata[?Status==`Active`].AccessKeyId' --output text)
for KEY in $OLD_KEYS; do
  if [ "$KEY" != "$NEW_ACCESS_KEY" ]; then
    aws iam update-access-key --access-key-id $KEY --status Inactive --user-name $USER_NAME
    echo "Disabled old access key: $KEY"
  fi
done

# Delete inactive keys older than 30 days
for KEY in $(aws iam list-access-keys --user-name $USER_NAME --query 'AccessKeyMetadata[?Status==`Inactive`].AccessKeyId' --output text); do
  if [[ $(aws iam get-access-key-last-used --access-key-id $KEY --query 'AccessKeyLastUsed.LastUsedDate') -lt $(date -d '30 days ago' +%Y-%m-%d) ]]; then
    aws iam delete-access-key --access-key-id $KEY --user-name $USER_NAME
    echo "Deleted old inactive access key: $KEY"
  fi
done
