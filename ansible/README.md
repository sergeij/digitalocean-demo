# Ansible

Ansible configuration to provision and configure a Kubernetes cluster on DigitalOcean.  
Run this after the infrastructure has been provisioned with Terraform.

## Notes

- Ansible dynamic inventory is used (`inventory/digitalocean.yml`), verify its configuration before running.
- Review `roles/common/README.md` and `roles/kubernetes/README.md` and update variables accordingly. If you need to manage multiple clusters/vpcs, create separate group variables or inventories for each.
- The `k8s`, `k8s_master` and `k8s_worker` tags defined in Terraform are used to bootstrap the Kubernetes cluster. Update these manually if you change the tags in Terraform.
- DigitalOcean API token and VPC ID environment variables must be set before running:

```sh
export DO_API_TOKEN=<DO_TOKEN>
export DO_CLUSTER_VPC_ID=<DO_VPC_ID>
```

- You can obtain the VPC ID with this command:

```sh
curl -s -X GET "https://api.digitalocean.com/v2/vpcs" \
  -H "Authorization: Bearer $DO_API_TOKEN" \
  | jq -r '.vpcs[] | select(.name == "demo") | .id'
```

## Usage

Example playbook snippet:

```yaml
    - hosts: k8s
      become: true
      gather_facts: true
      roles:
        - common
        - kubernetes
```

```sh
ansible-playbook -i inventory site.yml --limit=demo
```
