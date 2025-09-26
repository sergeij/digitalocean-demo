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

variable "vpc_uuid" {
  type        = string
  description = "The UUID of the VPC to assign the loadbalancer to"
}
