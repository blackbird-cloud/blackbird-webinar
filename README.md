# Blackbird Cloud AWS Cloud Environment Template


[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://blackbird.cloud)

## Intro

We (Blackbird Cloud) have deployed many AWS cloud environment for our clients. We use this repository as a boilerplate for our cloud deployment.

This Repository includes:
* Account management
* Organization management
* GitHub OIDC Stack
* GitOps (GitHub Action) pipeline
* Stacksets for common resources in every accounts (TF State Bucket, GitHub Role, etc)

## How to deploy

1. Create AWS Account, make sure you note down the account name and account id
2. Select the region you want to create your environment in, and note it down
3. Deploy Both `stacks/github-oidc-provider.yaml` and `stacks/terraform-state.yaml` to CloudFormation
    * For github oidc provider stack fill in `SubjectClaimFilters` with the following format `repo:YOUR_ORGANIZATION/YOUR_REPO:ref:refs/heads/BRANCH_NAME` we advise to deploy use `main` as branch name. This is nessecary to make sure that only GitHub Actions that run on the main branch are allowed to plan and apply changes on AWS
    * Once the terraform state stack is done note down the bucket name, it will be used as the state bucket for the next steps.
4. Go to Settings of your Github project, Security => Secrets and variables => Actions, and configure AWS_REGION and AWS_IAM_ROLE with the region that hosts your cloud, and the IAM role arn which the github oidc provider created.
5. On .github/workflows/aws_deployment.yml update all occurences of `my-root-account-name` to your AWS account name, and `my-project-name` to your github project name.
6. On `cloud/global.hcl` enter all the information under `MANUAL STEP: Enter manually` block
7. On` cloud/my-root-account-name/terragrunt.hcl` enter all the information under `MANUAL STEP: Enter manually` block
8. Create the users list on `cloud/my-root-account-name/02-iam-sso/01-users/terragrunt.hcl`, you can remove `john.doe@email.com`.
9. On `cloud/my-root-account-name/02-iam-sso/02-groups/terragrunt.hcl` enter the groups with the users you would like to create. Make sure to assign the users created by adding multiple `dependency.users.outputs.users["USER_EMAIL"].user_id` and replace `USER_EMAIL` with the actual email.
10. (Optional) On `cloud/my-root-account-name/02-iam-sso/03-permission-sets/terragrunt.hcl` enter the permission-sets you would like to create. We've included our default permission sets that we use for common use cases
11. (Optional) On `cloud/my-root-account-name/02-iam-sso/04-account-assignment/terragrunt.hcl` assign accounts and permission-sets, to users and groups. The default value will deploy `AdministratorAccess` permission set along with attached users on all accounts.
12. Rename the folder `cloud/my-root-account-name` to your your root account name created on step 1.

## Future improvements

[] Make Cloudformation bucket public with templates

[] Double check CI files and remove hardcodes

[] Add mock outputs to organization dependencies

## About Blackbird Cloud

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://blackbird.cloud)