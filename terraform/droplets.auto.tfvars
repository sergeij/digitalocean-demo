droplets = {
  "k8s-master-1" = {
    region   = "fra1"
    image    = "ubuntu-22-04-x64"
    size     = "s-2vcpu-4gb"
    ssh_keys = ["ansible"]
    tags     = ["k8s", "k8s_master", "demo"]
  },
  "k8s-master-2" = {
    region   = "fra1"
    image    = "ubuntu-22-04-x64"
    size     = "s-2vcpu-4gb"
    ssh_keys = ["ansible"]
    tags     = ["k8s", "k8s_master", "demo"]
  },
  "k8s-master-3" = {
    region   = "fra1"
    image    = "ubuntu-22-04-x64"
    size     = "s-2vcpu-4gb"
    ssh_keys = ["ansible"]
    tags     = ["k8s", "k8s_master", "demo"]
  },
  "k8s-worker-1" = {
    region   = "fra1"
    image    = "ubuntu-22-04-x64"
    size     = "s-2vcpu-4gb"
    ssh_keys = ["ansible"]
    tags     = ["k8s", "k8s_worker", "demo"]
  },
  "k8s-worker-2" = {
    region   = "fra1"
    image    = "ubuntu-22-04-x64"
    size     = "s-2vcpu-4gb"
    ssh_keys = ["ansible"]
    tags     = ["k8s", "k8s_worker", "demo"]
  },
  "k8s-worker-3" = {
    region   = "fra1"
    image    = "ubuntu-22-04-x64"
    size     = "s-2vcpu-4gb"
    ssh_keys = ["ansible"]
    tags     = ["k8s", "k8s_worker", "demo"]
  }
}
