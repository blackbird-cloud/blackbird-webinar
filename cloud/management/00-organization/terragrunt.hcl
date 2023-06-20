include {
  path = find_in_parent_folders()
}

locals {
  global = read_terragrunt_config(find_in_parent_folders("global.hcl")).locals
}

terraform {
  source = "tfr:///blackbird-cloud/organization/aws//?version=2.1.0"
}

inputs = {
  aws_service_access_principals = [
    "sso.amazonaws.com",
    "backup.amazonaws.com",
    "securityhub.amazonaws.com",
    "guardduty.amazonaws.com",
    "inspector2.amazonaws.com",
    "aws-artifact-account-sync.amazonaws.com",
    "health.amazonaws.com",
    "member.org.stacksets.cloudformation.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "ram.amazonaws.com",
    "ssm.amazonaws.com",
    "ipam.amazonaws.com",
    "reachabilityanalyzer.networkinsights.amazonaws.com",
    "reporting.trustedadvisor.amazonaws.com",
    "servicequotas.amazonaws.com",
    "account.amazonaws.com",
    "config-multiaccountsetup.amazonaws.com",
    "malware-protection.guardduty.amazonaws.com"
  ]
  enabled_policy_types = [] # ["BACKUP_POLICY", "SERVICE_CONTROL_POLICY", "TAG_POLICY"]
  feature_set          = "ALL"
  organizational_units = [
    {
      name                 = "management"
      organizational_units = []
      accounts             = []
      tags                 = {}
    },
    {
      name     = "environments"
      accounts = []
      tags     = {}
      organizational_units = [
        {
          name                 = "develop"
          organizational_units = []
          accounts             = []
          tags                 = {}
        },
        {
          name                 = "production"
          organizational_units = []
          accounts             = []
          tags                 = {}
        }
      ],
    },
    {
      name                 = "tooling"
      organizational_units = []
      tags                 = {}
      accounts = [
        {
          name                             = "monitoring"
          email                            = "info+${local.global.account_email_label_prefix}-monitoring@blackbird.cloud"
          delegated_administrator_services = []
        },
      ]
    },
    {
      name                 = "compliance"
      organizational_units = []
      tags                 = {}
      accounts = [
        {
          name  = "security"
          email = "info+${local.global.account_email_label_prefix}-security@blackbird.cloud"
          delegated_administrator_services = [
            "config.amazonaws.com",
            "guardduty.amazonaws.com",
            "inspector2.amazonaws.com",
            "securityhub.amazonaws.com",
            "config-multiaccountsetup.amazonaws.com"
          ]
        }
      ]
    }
  ]

  organizations_policies = {}
  # https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services_list.html

  securityhub_auto_enable = true

  primary_contact = {
    address_line_1  = "Bos en Lommerplein 280"
    address_line_2  = "5.10"
    city            = "Amsterdam"
    company_name    = "Blackbird Cloud VOF"
    country_code    = "NL"
    postal_code     = "1055WR"
    state_or_region = "Noord-Holland"
    phone_number    = "+31613034840"
    website_url     = "https://www.blackbird.cloud"
    full_name       = "Joeri Malmberg"
  }

  billing_contact = {
    name          = "Joeri Malmberg"
    title         = "Co-founder"
    email_address = "info@blackbird.cloud"
    phone_number  = "+31613034840"
  }

  security_contact = {
    name          = "Joeri Malmberg"
    title         = "Co-founder"
    email_address = "info@blackbird.cloud"
    phone_number  = "+31613034840"
  }

  operations_contact = {
    name          = "Joeri Malmberg"
    title         = "Co-founder"
    email_address = "info@blackbird.cloud"
    phone_number  = "+31613034840"
  }
}
