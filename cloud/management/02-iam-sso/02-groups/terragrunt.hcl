include {
  path = find_in_parent_folders()
}

dependency "users" {
  config_path = "..//01-users"
  mock_outputs = {
    users = {
      "joeri.malmberg@blackbird.cloud" = {
        user_id = "user_id"
      }
      "sakif.surur@blackbird.cloud" = {
        user_id = "user_id"
      }
    }
  }
}

dependency "organization" {
  config_path  = "../..//00-organization"
  skip_outputs = true
}

terraform {
  source = "tfr:///blackbird-cloud/identitystore/aws//modules/groups?version=1.0.3"
}

inputs = {
  groups = [
    {
      display_name = "Administrators"
      description  = "Administrators"
      members = [
        dependency.users.outputs.users["joeri.malmberg@blackbird.cloud"].user_id,
        dependency.users.outputs.users["sakif.surur@blackbird.cloud"].user_id,
      ]
    }
  ]
}
