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
