terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

resource "digitalocean_database_cluster" "database_cluster" {
  for_each = var.database_clusters

  name       = each.key
  engine     = each.value.engine
  version    = each.value.version
  region     = each.value.region
  size       = each.value.size
  node_count = each.value.node_count
  tags       = each.value.tags
}

resource "digitalocean_database_user" "db_user" {
  for_each = var.database_clusters

  cluster_id = digitalocean_database_cluster.database_cluster[each.key].id
  name       = each.value.db_user
}

resource "digitalocean_database_firewall" "db_firewall" {
  for_each = var.database_clusters

  cluster_id = digitalocean_database_cluster.database_cluster[each.key].id

  dynamic "rule" {
    for_each = each.value.allowed_cidrs
    content {
      type  = "ip_addr"
      value = rule.value
    }
  }
}
