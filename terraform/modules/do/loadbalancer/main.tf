terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

resource "digitalocean_loadbalancer" "this" {
  for_each = var.loadbalancers

  name     = each.key
  region   = each.value.region
  network  = each.value.network
  vpc_uuid = var.vpc_uuid

  dynamic "forwarding_rule" {
    for_each = each.value.forwarding_rules
    content {
      entry_protocol  = forwarding_rule.value.entry_protocol
      entry_port      = forwarding_rule.value.entry_port
      target_protocol = forwarding_rule.value.target_protocol
      target_port     = forwarding_rule.value.target_port
    }
  }

  healthcheck {
    protocol = each.value.healthcheck.protocol
    port     = each.value.healthcheck.port
  }

  droplet_tag = each.value.droplet_tag
}
