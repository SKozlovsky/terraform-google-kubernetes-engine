# Shared VPC Cluster

This example demonstrates how to create a simple cluster using the shared VPC helper submodule.
The network will be deployed in the host project and the cluster will be deployed in the service project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| billing\_account | The billing account id associated with the project, e.g. XXXXXX-YYYYYY-ZZZZZZ | string | n/a | yes |
| folder\_id | Folder to create shared vpc host and service projects in | string | n/a | yes |
| gke\_service\_project | The service project ID to host the cluster in | string | n/a | yes |
| gke\_shared\_host\_project | The GCP project housing the VPC network to host the cluster in | string | n/a | yes |
| region | The region to host the cluster in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ca\_certificate |  |
| client\_token |  |
| cluster\_name | Cluster name |
| host\_project\_id |  |
| host\_project\_number |  |
| ip\_range\_pods | The secondary IP range used for pods |
| ip\_range\_services | The secondary IP range used for services |
| kubernetes\_endpoint |  |
| location |  |
| master\_kubernetes\_version | The master Kubernetes version |
| network |  |
| project\_id |  |
| project\_number |  |
| region |  |
| service\_account | The default service account used for running nodes. |
| subnetwork |  |
| zones | List of zones in which the cluster resides |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## IAM Requirements

You must have the following roles assigned to the `folder_id`:

```hcl
[
  "roles/compute.admin",
  "roles/compute.networkAdmin",
  "roles/owner",
  "roles/resourcemanager.projectCreator",
  "roles/resourcemanager.folderAdmin",
  "roles/resourcemanager.folderIamAdmin",
  "roles/billing.projectManager",
  "roles/compute.xpnAdmin",
  "roles/resourcemanager.projectIamAdmin"
]
```

## Install

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
