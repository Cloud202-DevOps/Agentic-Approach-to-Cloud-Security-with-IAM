# IAM Security Best Practices Summary

## Principle of Least Privilege
Always grant the minimal permissions necessary for each role. Avoid using overly permissive policies, especially on critical resources.

## Enforce MFA
Enable MFA on all accounts that have access to sensitive data or elevated permissions. MFA should be mandatory for users with console access.

## Access Key Management
Rotate access keys every 90 days. Avoid using long-term credentials and prefer IAM roles over access keys where possible.

## Role-Based Access Control (RBAC)
Organize IAM users into groups (e.g., Developer, Admin, ReadOnly) and assign policies to groups rather than individual users.

## Policy Audits and Compliance
Regularly audit IAM policies for compliance with organizational standards. Look for unused or overly permissive policies and apply conditions for extra security.

## Log and Monitor IAM Activities
Enable CloudTrail logging for IAM to monitor and detect suspicious activity. Use CloudWatch alarms to get alerts on critical IAM events.
