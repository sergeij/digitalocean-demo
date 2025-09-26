# kubernetes

Ansible role to install and configures Kubernetes cluster.

## Features

This role currently:

- Bootstraps a fully functional Kubernetes cluster with multiple control plane and worker nodes.
- Allows new nodes to be added on the fly.
- Installs [Cilium](https://cilium.io/) for container networking, with support for service mesh, ingress, Hubble, and more.
- Can install custom Kubernetes manifests.
- Can install Helm charts.

## Requirements

- Ansible core 2.17.12 or newer
- OS: Ubuntu 22.04 (can be adjusted)

## Variables

### Kubernetes Versions

```yaml
kubernetes_containerd_version: "1.7.27-0ubuntu1~22.04.1"
kubernetes_major_version: "1.34"
kubernetes_minor_version: "1.34.1-1.1"
```

### Cluster Configuration

```yaml
kubernetes_cluster_name: "demo"
kubernetes_pod_network_cidr: "192.168.0.0/24"
kubernetes_control_plane_endpoint: "10.10.0.6"
kubernetes_default_network_interface: "eth1"
```

### Cilium Configuration

```yaml
kubernetes_cilium_version: "1.17.8"
```

### Secrets to Create

```yaml
kubernetes_secrets:
  - name: digitalocean
    namespace: kube-system
    string_data:
      access-token: "{{ lookup('env', 'DO_API_TOKEN') }}"
      vpc-id: "{{ lookup('env', 'DO_CLUSTER_VPC_ID') }}"
```

### Additional Manifests

```yaml
kubernetes_manifests:
  - digitalocean-cloud-controller-manager.yaml
  - digitalocean-cloud-controller-manager-admission-server.yaml
  - letsencrypt.yaml
```

### Helm Charts

```yaml
kubernetes_helm_charts:
  - name: cert-manager
    repo_name: jetstack
    repo_url: https://charts.jetstack.io
    chart: cert-manager
    namespace: cert-manager
    create_namespace: true
    version: v1.18.2
    values_file: cert-manager.yaml
  - name: nginx-ingress
    repo_name: ingress-nginx
    repo_url: https://kubernetes.github.io/ingress-nginx
    chart: ingress-nginx
    namespace: ingress-nginx
    create_namespace: true
    version: 4.12.6
    values_file: nginx-ingress.yaml
```

## Example Playbook

```yaml
    - hosts: k8s
      become: true
      roles:
        - kubernetes


Run with:

```sh
ansible-playbook -i inventory kubernetes.yml --limit=demo
```

## Directory Structure

```sh
.
├── README.md
├── defaults
│   └── main.yml
├── files
│   ├── helm_values
│   │   ├── cert-manager.yaml
│   │   └── nginx-ingress.yaml
│   └── manifests
│       ├── digitalocean-cloud-controller-manager-admission-server.yaml
│       ├── digitalocean-cloud-controller-manager.yaml
│       └── letsencrypt.yaml
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── tasks
│   ├── bootstrap.yml
│   ├── cilium.yml
│   ├── containerd.yml
│   ├── helm.yml
│   ├── main.yml
│   ├── manifests.yml
│   ├── secrets.yml
│   ├── swap.yml
│   └── sysctl.yml
├── templates
└── vars
    └── main.yml
```

## Notes

- This role is designed to be idempotent and safe to run multiple times.
