# Use Cases for Agentic Approach in IAM Automation

## Use Case 1: Automated IAM User Onboarding

- **Scenario**: Automate the onboarding of new users by ensuring they receive only the necessary permissions (least privilege) and have Multi-Factor Authentication (MFA) enforced for added security.

- **Configuration and Commands**:
  - **Create User**: Configure the `CreateUser` action group to automatically create new users with minimal permissions.
  - **Assign to Group**: Add users to predefined IAM groups based on their roles (e.g., ReadOnly or Developer).
  - **Enforce MFA**: Use the `EnforceMFA` action group to mandate MFA on all new user accounts.

- **Example JSON Configuration**:
  ```json
  {
    "actionGroup": "CreateUser",
    "userName": "NewUser",
    "groupAssignment": ["DeveloperGroup"],
    "enforceMFA": true,
    "permissions": ["iam:CreateUser", "iam:AddUserToGroup", "iam:EnableMFADevice"]
  }
