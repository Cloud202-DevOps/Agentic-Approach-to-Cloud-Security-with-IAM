# CI/CD Pipeline for Agent Deployment

## Automating Agent Deployment with GitHub Actions

This section provides a guide to setting up a CI/CD pipeline using GitHub Actions for automated deployment of the AWS Bedrock Agent and its action groups.

1. **Step-by-Step Guide**:  
   - Navigate to the `ci-cd/Setup_GitHub_Actions.md` file for a complete, step-by-step guide to configuring the CI/CD pipeline.
   - Includes instructions on setting up required secrets, permissions, and GitHub Action workflows for deploying IAM automation.

2. **YAML Configuration File**:  
   - A sample YAML file is provided to streamline the deployment of the agent and action groups. Place this configuration in the `.github/workflows` directory in your repository.
   - Example YAML file:

     ```yaml
     name: Deploy IAM Agent

     on:
       push:
         branches:
           - main

     jobs:
       deploy-agent:
         runs-on: ubuntu-latest

         steps:
           - name: Checkout Code
             uses: actions/checkout@v2

           - name: Set up AWS CLI
             uses: aws-actions/configure-aws-credentials@v1
             with:
               aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
               aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
               aws-region: us-west-2

           - name: Deploy IAM Agent
             run: |
               aws bedrock deploy-agent --config-file ./agent-config.json
     ```

## Automated Testing for IAM Configurations

1. **Setting Up Automated Tests**:  
   - Configure automated tests to verify that each IAM action group performs as expected.
   - Use test workflows to validate user creation, MFA enforcement, and policy assignment.

2. **Example Test Cases**:  
   - **User Creation**: Verify that the `CreateUser` action group successfully creates new users with correct permissions.
   - **MFA Enforcement**: Check that MFA is enforced for specified users as per the `EnforceMFA` action group.
   - **Policy Assignment**: Confirm that policies are correctly assigned to users and roles, ensuring adherence to least privilege.

Example Test YAML Configuration:

   ```yaml
   name: Test IAM Configurations

   on:
     pull_request:
       branches:
         - main

   jobs:
     test-iam-config:
       runs-on: ubuntu-latest

       steps:
         - name: Checkout Code
           uses: actions/checkout@v2

         - name: Run IAM Tests
           run: |
             pytest tests/test_iam_configurations.py
