#------------------------------------------------------------------------------
# Sentinel Modules (function imports)
#------------------------------------------------------------------------------
module "tfplan-functions" {
  source = "./functions/tfplan-functions.sentinel"
}

module "tfconfig-functions" {
  source = "./functions/tfconfig-functions.sentinel"
}

module "aws-functions" {
  source = "./functions/aws-functions.sentinel"
}

#------------------------------------------------------------------------------
# Sentinel Policies
#------------------------------------------------------------------------------
policy "enforce-required-tags" {
  source            = "./policies/aws/enforce-hcp-packer-images.sentinel"
  enforcement_level = "advisory"
}
