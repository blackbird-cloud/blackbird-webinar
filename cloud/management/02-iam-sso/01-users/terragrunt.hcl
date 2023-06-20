include {
  path = find_in_parent_folders()
}

dependency "organization" {
  config_path  = "../..//00-organization"
  skip_outputs = true
}

terraform {
  source = "tfr:///blackbird-cloud/identitystore/aws//modules/users?version=1.0.3"
}

inputs = {
  users = [
    {
      email       = "joeri.malmberg@blackbird.cloud"
      user_name   = "joeri.malmberg@blackbird.cloud"
      given_name  = "joeri"
      family_name = "malmberg"
    },
    {
      email       = "sakif.surur@blackbird.cloud"
      user_name   = "sakif.surur@blackbird.cloud"
      given_name  = "sakif"
      family_name = "surur"
    }
  ]
}
