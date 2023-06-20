locals {
  account_email_label_prefix = local.project
  administrator_role_name    = "AdministratorAccess"
  github_role_name           = "GitHub"

  ### MANUAL STEP: Enter manually
  region            = "eu-central-1"
  organization_name = "blackbird-webinar"
  project           = "blackbird-webinar"
  github_role_arn   = "arn:aws:iam::570100275646:role/GitHub"
  ## ===========================
}
