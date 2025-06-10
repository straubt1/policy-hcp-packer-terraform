import "static" "hcp-test-config" {
  source = "./source/hcp.json" # This file does not have values set, but is required for Sentinel to run
  format = "json"
}

import "module" "tfplan-functions" {
  source = "./functions/tfplan-functions.sentinel"
}

import "module" "aws-functions" {
  source = "./functions/aws-functions.sentinel"
}

import "module" "hcp-packer-functions" {
  source = "./functions/hcp-packer-functions.sentinel"
}

policy "aws-enforce-hcp-packer-images" {
  source            = "./policies/aws/enforce-hcp-packer-images.sentinel"
  enforcement_level = "advisory"
}
