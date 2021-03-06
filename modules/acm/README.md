# Terraform Kubernetes Engine ACM Submodule

This module installs [Anthos Config Management](https://cloud.google.com/anthos-config-management/docs/) (ACM) in a Kubernetes cluster.

Specifically, this module automates the following steps for [installing ACM](https://cloud.google.com/anthos-config-management/docs/how-to/installing):
1. Installing the ACM Operator on your cluster.
2. Generating an SSH key for accessing Git and providing it to the Operator
3. Configuring the Operator to connect to your ACM repository

## Usage

There is a [full example](../../examples/simple_zonal_with_acm) provided. Simple usage is as follows:

```tf
module "acm" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/acm"

  project_id       = "my-project-id"
  cluster_name     = "my-cluster-name"
  location         = module.gke.location
  cluster_endpoint = module.gke.endpoint

  sync_repo        = "git@github.com:GoogleCloudPlatform/csp-config-management.git"
  sync_branch      = "1.0.0"
  policy_dir       = "foo-corp"
}
```

To deploy this config:
1. Run `terraform apply`
2. Inspect the `git_creds_public` [output](#outputs) to retrieve the public key used for accessing Git. Whitelist this key for access to your Git repo. Instructions for some popular Git hosting providers are included for convenience:

  * [Cloud Souce Repositories](https://cloud.google.com/source-repositories/docs/authentication#ssh)
  * [Bitbucket](https://confluence.atlassian.com/bitbucket/set-up-an-ssh-key-728138079.html)
  * [GitHub](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)
  * [Gitlab](https://docs.gitlab.com/ee/ssh/)

## Whitelisting
Note that installing Anthos Config Management [requires](https://cloud.google.com/anthos-config-management/docs/how-to/installing#local_environment) an active Anthos license.
By default, this module will attempt to download the ACM operator from Google directly—meaning your Terraform service account needs to be whitelisted for ACM access. If this is an issue, you can predownload the operator yourself then set the `operator_path` variable to point to the file location.

 <!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_endpoint | Kubernetes cluster endpoint. | string | n/a | yes |
| cluster\_name | The unique name to identify the cluster in ACM. | string | n/a | yes |
| create\_ssh\_key | Controls whether a key will be generated for Git authentication | bool | `"true"` | no |
| enable\_policy\_controller | Whether to enable the ACM Policy Controller on the cluster | bool | `"true"` | no |
| install\_template\_library | Whether to install the default Policy Controller template library | bool | `"true"` | no |
| location | The location (zone or region) this cluster has been created in. | string | n/a | yes |
| operator\_path | Path to the operator yaml config. If unset, will download from GCS releases. | string | `"null"` | no |
| policy\_dir | Subfolder containing configs in ACM Git repo | string | n/a | yes |
| project\_id | The project in which the resource belongs. | string | n/a | yes |
| sync\_branch | ACM repo Git branch | string | `"master"` | no |
| sync\_repo | ACM Git repo address | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| git\_creds\_public | Public key of SSH keypair to allow the Anthos Operator to authenticate to your Git repository. |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
