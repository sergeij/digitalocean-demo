variable "token" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_region" {
  type = string
}

variable "vpc_ip_range" {
  type = string
}

variable "droplets" {
  type = map(object({
    region   = string
    image    = string
    size     = string
    ssh_keys = list(string)
    tags     = list(string)
  }))
  description = "Input map of droplets to create"
}

variable "firewalls" {
  type = map(object({
    tags = list(string)
    inbound_rules = list(object({
      protocol         = string
      port_range       = string
      source_addresses = list(string)
    }))
    outbound_rules = list(object({
      protocol              = string
      port_range            = string
      destination_addresses = list(string)
    }))
  }))

  description = "Map of firewall definitions by role"
}

variable "loadbalancers" {
  type = map(object({
    region      = string
    droplet_tag = string
    network     = string
    forwarding_rules = list(object({
      entry_protocol  = string
      entry_port      = number
      target_protocol = string
      target_port     = number
    }))
    healthcheck = object({
      protocol = string
      port     = number
    })
  }))
}

variable "database_clusters" {
  type = map(object({
    engine        = string
    version       = string
    region        = string
    size          = string
    node_count    = number
    tags          = list(string)
    db_user       = string
    allowed_cidrs = list(string)
  }))
}
