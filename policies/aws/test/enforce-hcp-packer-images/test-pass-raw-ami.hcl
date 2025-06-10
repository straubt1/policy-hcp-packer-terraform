# Results
test {
  rules = {
    main = true
  }
}

# Mocks
import "static" "hcp-test-config" {
  source = "../../../../secrets/hcp.json"
  format = "json"
}

mock "tfplan/v2" {
  module {
    source = "mock-tfplan-pass-raw-ami.sentinel"
  }
}

# Functions
mock "logging-functions" {
  module {
    source = "../../../../functions/logging-functions.sentinel"
  }
}

mock "tfplan-functions" {
  module {
    source = "../../../../functions/tfplan-functions.sentinel"
  }
}

mock "hcp-packer-functions" {
  module {
    source = "../../../../functions/hcp-packer-functions.sentinel"
  }
}