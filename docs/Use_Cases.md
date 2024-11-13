# Use Cases for Agentic Approach in IAM Automation

## Use Case 1: Automated IAM User Onboarding

- **Scenario**: Automate the onboarding process for new users with a focus on enforcing the principle of least privilege and mandatory Multi-Factor Authentication (MFA).
- **Configuration and Commands**:
  - Example commands for creating new IAM users, assigning them to appropriate groups, and enforcing MFA upon initial login.
  - Configuration files to automate this process using the Bedrock Agent's `CreateUser` and `EnforceMFA` action groups.

## Use Case 2: Policy Compliance and Auditing

- **Scenario**: Continuously monitor and enforce policy compliance on IAM roles and users to ensure security and adherence to organizational policies.
- **Configuration**:
  - Use the `MonitorPolicyCompliance` action group to regularly check for compliance across IAM policies.
  - Set up alerts for policy deviations or suspicious IAM activities, ensuring immediate response and remediation.

## Use Case 3: Adaptive Permissions Based on Real-Time Usage

- **Scenario**: Dynamically adapt IAM permissions based on real-time usage and recommendations provided by the agent.
- **Setup Steps**:
  - Configure adaptive IAM policies that respond to agent observations, ensuring permissions evolve to match actual usage patterns without compromising security.
  - Use the Bedrock Agent to recommend permission adjustments, aligning with changing access needs while maintaining least privilege.

Explore each use case for practical applications of agent-driven IAM management in AWS.

