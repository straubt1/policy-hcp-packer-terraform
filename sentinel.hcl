#------------------------------------------------------------------------------
# Sentinel Modules (function imports)
#------------------------------------------------------------------------------
import "module" "tfplan-functions" {
  source = "./functions/tfplan-functions.sentinel"
}

import "module" "aws-functions" {
  source = "./functions/aws-functions.sentinel"
}

import "module" "hcp-packer-functions" {
  source = "./functions/hcp-packer-functions.sentinel"
}

#------------------------------------------------------------------------------
# Sentinel Policies
#------------------------------------------------------------------------------
policy "enforce-hcp-packer-images" {
  source            = "./policies/aws/enforce-hcp-packer-images.sentinel"
  enforcement_level = "advisory"
}
