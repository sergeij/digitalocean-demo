firewalls = {
  "SSH" = {
    tags = ["k8s"],
    inbound_rules = [
      {
        protocol         = "tcp"
        port_range       = "22"
        source_addresses = ["0.0.0.0/0"]
      }
    ],
    outbound_rules = []
  },
  "K8s" = {
    tags = ["k8s"],
    inbound_rules = [
      {
        protocol         = "tcp"
        port_range       = "1-65535"
        source_addresses = ["10.10.0.0/16", "192.168.0.0/24", "10.96.0.0/12"]
      },
      {
        protocol         = "udp"
        port_range       = "1-65535"
        source_addresses = ["10.10.0.0/16", "192.168.0.0/24", "10.96.0.0/12"]
      }
    ],
    outbound_rules = [
      {
        protocol              = "tcp"
        port_range            = "1-65535"
        destination_addresses = ["0.0.0.0/0"]
      },
      {
        protocol              = "udp"
        port_range            = "1-65535"
        destination_addresses = ["0.0.0.0/0"]
      }
    ]
  },
  "HTTP" = {
    tags = ["k8s_worker"],
    inbound_rules = [
      {
        protocol         = "tcp"
        port_range       = "80"
        source_addresses = ["0.0.0.0/0"]
      },
      {
        protocol         = "tcp"
        port_range       = "443"
        source_addresses = ["0.0.0.0/0"]
      }
    ],
    outbound_rules = []
  }
}
