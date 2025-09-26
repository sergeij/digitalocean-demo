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
