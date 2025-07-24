# Results
test {
  rules = {
    main = false
  }
}

# Mocks
mock "tfplan/v2" {
  module {
    source = "mock-tfplan-fail-raw-ami.sentinel"
  }
}

# Functions
import "static" "hcp-test-config" {
  source = "../../../../secrets/hcp.json"
  format = "json"
}

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
    source = "../../../../functions/hcp-packer-functions-original.sentinel"
  }
}