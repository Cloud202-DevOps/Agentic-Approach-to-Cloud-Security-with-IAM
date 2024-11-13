#!/bin/bash

# Variables
USER_NAME="NewUser"
GROUP_NAME="ReadOnlyGroup"
POLICY_ARN="arn:aws:iam::aws:policy/ReadOnlyAccess"

# Create IAM User
aws iam create-user --user-name $USER_NAME

# Create and add user to the group if it doesn't exist
if ! aws iam get-group --group-name $GROUP_NAME > /dev/null 2>&1; then
  aws iam create-group --group-name $GROUP_NAME
fi
aws iam add-user-to-group --user-name $USER_NAME --group-name $GROUP_NAME

# Attach policy to the group
aws iam attach-group-policy --group-name $GROUP_NAME --policy-arn $POLICY_ARN

# Enforce MFA
aws iam create-virtual-mfa-device --virtual-mfa-device-name $USER_NAME-MFA --outfile /tmp/$USER_NAME-QRCode.png
echo "Please scan the QR code from /tmp/$USER_NAME-QRCode.png with your MFA app and register the device."

echo "User $USER_NAME created and assigned to $GROUP_NAME with MFA required."
