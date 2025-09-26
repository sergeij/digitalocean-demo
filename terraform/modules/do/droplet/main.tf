terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

data "digitalocean_ssh_keys" "keys" {}

locals {
  ssh_key_map = {
    for key in data.digitalocean_ssh_keys.keys.ssh_keys : key.name => key.id
  }
}

resource "digitalocean_droplet" "this" {
  for_each = var.droplets

  name   = each.key
  region = each.value.region
  image  = each.value.image
  size   = each.value.size
  ssh_keys = [
    for key_name in each.value.ssh_keys : lookup(local.ssh_key_map, key_name, null)
  ]
  tags     = each.value.tags
  vpc_uuid = var.vpc_uuid
}
