# DigitalOcean Demo

Demo project showing how to provision DigitalOcean infrastructure (Droplets, Firewalls, Load Balancers, Database Clusters, VPCs) and configure a self-managed Kubernetes cluster with Cilium (CNI) and the DigitalOcean Cloud Controller Manager for Load Balancers.

## Prerequisites

- Terraform v1.13.3
- Ansible (core 2.17.12+)
- A valid DigitalOcean API Token

## 1. Install Terraform

```sh
wget https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_amd64.zip
unzip terraform_1.13.3_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

## 2. Provision Infrastructure with Terraform

Create DO personal access token https://docs.digitalocean.com/reference/api/create-personal-access-token/

```sh
export TF_VAR_token="<DO_API_TOKEN>"
```

Edit droplets.auto.tfvars to configure your SSH keys. Ensure that the ssh_keys values match your SSH key names on DigitalOcean.

Then run:

```sh
cd terraform
terraform init
terraform plan
terraform apply
```

## 3. Get Kubernetes Load Balancer IP

Run this to extract the IP of the load balancer named `k8s-api-lb`:

```sh
export DO_API_TOKEN=<DO_API_TOKEN>
curl -s -X GET "https://api.digitalocean.com/v2/load_balancers" \
  -H "Authorization: Bearer $DO_API_TOKEN" | jq -r '.load_balancers[] | select(.name == "k8s-api-lb") | .ip'
```

Copy the output IP (e.g. 10.10.0.6) and update the variable `kubernetes_control_plane_endpoint` in:

```yaml
ansible/inventory/group_vars/demo/vars.yml
```

## 4. Install Ansible

```sh
apt install python3-pip
pip install --upgrade pip
pip install ansible
ansible --version
```

## 5. Run Ansible

Export required environment variables:

```sh
export DO_API_TOKEN=<DO_TOKEN>
```

Get the VPC ID:

```sh
curl -s -X GET "https://api.digitalocean.com/v2/vpcs" \
  -H "Authorization: Bearer $DO_API_TOKEN" \
  | jq -r '.vpcs[] | select(.name == "demo") | .id'
```

Then export it:

```sh
export DO_CLUSTER_VPC_ID=<DO_VPC_ID>
```

Run the playbook:

```sh
cd ansible
ansible-playbook -i inventory site.yml --limit=demo
```

## 6. Deploy Example NGINX App

Open `app/nginx.yaml` and update the domain (e.g. replace `admins.cloud` with your own):

```sh
vim app/nginx.yaml
```

Copy the manifest to one of the control plane nodes and apply it:

```sh
scp app/nginx.yaml root@<master-node-ip>:/root/
ssh root@<master-node-ip>
kubectl apply -f nginx.yaml
```

Verify the deployment:

```sh
kubectl -n nginx get pods
```

The SSL certificate will be automatically issued using Let's Encrypt via cert-manager. To enable this, you must point demo.yourdomain.com to the external IP of the DigitalOcean Load Balancer.

You can find the external IP by running:

```sh
kubectl -n ingress-nginx get svc
```

Example output:

```sh
NAME                                           TYPE           CLUSTER-IP       EXTERNAL-IP                                   PORT(S)                      AGE
nginx-ingress-ingress-nginx-controller         LoadBalancer   10.111.240.35    159.223.250.173,2a03:b0c0:3:f0:0:1:752:4000   80:32461/TCP,443:31598/TCP   28m
```

## Notes

- Terraform state is stored locally.
- You can manage multiple clusters by creating separate group variables under the inventory/ directory.
- After all cluster initialization is complete, restart CoreDNS and cert-manager:
  ```sh
  kubectl -n kube-system rollout restart deployment coredns
  kubectl -n cert-manager rollout restart deployment cert-manager
  ```

## Hubble

<img width="1687" height="891" alt="hubble" src="https://github.com/user-attachments/assets/20851488-6b5b-417f-ae19-8ccdd183f149" />

