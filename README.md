# Sentinel Policies for HCP Packer

This repository contains Sentinel policies for HCP Packer. The policies are designed to enforce best practices and compliance standards for Packer images for Cloud consumption.

TODO:

- [ ] Add GCP policies
- [ ] Add Azure policies
- [ ] Optimize API calls to HCP Packer Registry

## Purpose

The purpose of these Sentinel policies is to ensure that Packer images are built in a secure and compliant manner, adhering to organizational standards and best practices. The policies cover various aspects of image creation, including security configurations, resource usage, and compliance with regulatory requirements.

### Policy Behavior

Each policy is designed to evaluate the Packer image configuration and enforce specific rules. The policies are written in Sentinel, a policy-as-code framework that allows for fine-grained control over infrastructure as code.

> [!Tip]
> These policies behaviors can be modified to suit your organization's needs. You can adjust the rules and conditions within the policies to align with your compliance requirements.

The expected behavior of these policies:

- If an image id (example `image_id` in AWS) is provided for a compute resource, the policy will check if the image exists in the HCP Packer Registry.
- If the image exists, the policy will verify its status.
  - If the image is in a valid state (e.g., `VERSION_ACTIVE`), the policy will pass.
  - If the image is in a revoked state (e.g., `VERSION_REVOKED`), the policy will fail.
  - If the image is in a deprecated state (e.g., `VERSION_REVOCATION_SCHEDULED`), the policy will print a warning, but the policy will still pass.
  - If the image is in any other state, the policy will fail.
- If the image does not exist the policy will trigger a violation and provide details for remediation.

## Usage

To use these Sentinel policies, you will need an HCP Packer Service account with the necessary permissions to access the Packer Registry (namely a Client ID and Client Secret). You will also need the HCP Organization ID and the HCP Project ID. For more information on how to create a service account, refer to the [HCP Packer documentation](https://developer.hashicorp.com/hcp/docs/hcp/api#authenticate-to-hcp).

These configuration values must be set as Parameters in the Policy Set, marking them as sensitive where appropriate. The policies will use these parameters to authenticate with the HCP Packer Registry and evaluate the image configurations.

## Policies

**AWS**

Location: `./policies/aws/enforce-hcp-packer-images.sentinel`

**GCP**

[TBD] Location: `./policies/gcp/enforce-hcp-packer-images.sentinel`

**Azure**

[TBD] Location: `./policies/azure/enforce-hcp-packer-images.sentinel`

## Functions

There are several Sentinel functions provided to facilitate policy enforcement. These functions are designed to be reusable across different policies and can be customized as needed.

### HCP Packer Functions

Location: `./functions/hcp-packer-functions.sentinel`

This function file contains the core logic for interacting with the HCP Packer Registry to make interactions easier.

Usage:

- Import the functions in your Sentinel policy file.
  - `import "hcp-packer-functions" as hcp`
- Call the `hcp.setHCPConfiguration()` function to set the necessary parameters for HCP Packer. This is done to avoid having to pass into every function the parameters needed to connect to HCP Packer.
- Get an Auth Token using `hcp.getAuthToken()`.
