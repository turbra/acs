# ACS API Examples

## Examples of API usage to perform configuration and reporting tasks with Red Hat Advanced Cluster Security

### Introduction:

This repository contains scripts to seamlessly integrate ACS Central with OpenShift for Single Sign-On (SSO) and to set up custom rules for user group management. The two main scripts in this repository are:

- `auth.sh`: This script integrates OpenShift with ACS Central for SSO.
- `rules.sh`: This script creates a custom rule in ACS Central that assigns a specific role to a user group from the OpenShift authentication provider.

### Requirements:

- `curl`: Required for making API calls.
- `jq`: Necessary for parsing and manipulating JSON data.
- ACS Central installation.
- OpenShift environment.

### Usage:

#### 1. Setting Up OpenShift Authentication (`auth-provider.sh`):

This script integrates ACS Central with OpenShift to enable Single Sign-On (SSO).

**Steps**:

- Update the `CENTRAL` and `CENTRAL_PASS` variables in the script to point to your Central instance and provide the correct password.
- Execute the script:

  ```bash
  sh auth-provider.sh
  ```

#### 2. Creating Custom Rules (`add-rule.sh`):

This script sets up a custom rule that grants the "Analyst" role to members of the `dev-group` within the OpenShift authentication provider.

**Steps**:

- Make sure you've run `auth.sh` first to establish the integration.
- Update the `CENTRAL` and `CENTRAL_PASS` variables in the script to match your Central instance and provide the correct password.
- Execute the script:

  ```bash
  sh add-rule.sh
  ```

The script will automatically fetch the ID of the existing OpenShift auth provider and use it to establish the custom rule.

