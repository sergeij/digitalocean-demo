# Terraform configuration

Terraform configuration to deploy infrastructure to DigitalOcean.

Currently, you can:
- Configure VPC
- Create firewalls
- Deploy droplets
- Configure Load balancer

## Requirements

- Terraform v1.12.2

## Directory Structure

```sh
.
├── README.md
├── databases.auto.tfvars
├── droplets.auto.tfvars
├── firewalls.auto.tfvars
├── loadbalancers.auto.tfvars
├── main.tf
├── modules
│   └── do
│       ├── database_cluster
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── droplet
│       │   ├── main.tf
│       │   └── variables.tf
│       ├── firewall
│       │   ├── main.tf
│       │   └── variables.tf
│       ├── loadbalancer
│       │   ├── main.tf
│       │   └── variables.tf
│       └── vpc
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
├── outputs.tf
├── variables.tf
└── vpc.auto.tfvars
```

## Example Usage

Define your infrastructure parameters in droplets.auto.tfvars (or other .auto.tfvars files):

```hcl
droplets = {
  "ansible-controller" = {
    region   = "fra1"
    image    = "ubuntu-22-04-x64"
    size     = "s-2vcpu-4gb"
    ssh_keys = ["your_ssh_key_name"]
    tags     = ["ansible"]
  },
  "k8s-master-1" = {
    region   = "fra1"
    image    = "ubuntu-22-04-x64"
    size     = "s-2vcpu-4gb"
    ssh_keys = ["your_ssh_key_name"]
    tags     = ["k8s", "k8s_master", "demo"]
  }
}
```

Run with:

```sh
terraform init
terraform plan
terraform apply
```

## Notes

- The Terraform state is stored locally by default (terraform.tfstate file). Consider configuring remote state (e.g., in an S3 bucket) for team collaboration and better state management.
