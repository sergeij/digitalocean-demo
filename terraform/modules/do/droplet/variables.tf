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

variable "vpc_uuid" {
  type        = string
  description = "The UUID of the VPC to assign the droplets to"
}
