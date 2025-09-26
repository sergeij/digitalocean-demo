loadbalancers = {
  k8s-api-lb = {
    region      = "fra1"
    droplet_tag = "k8s_master"
    network     = "INTERNAL"

    forwarding_rules = [
      {
        entry_protocol  = "tcp"
        entry_port      = 6443
        target_protocol = "tcp"
        target_port     = 6443
      }
    ]

    healthcheck = {
      protocol = "tcp"
      port     = 6443
    }
  }
}
