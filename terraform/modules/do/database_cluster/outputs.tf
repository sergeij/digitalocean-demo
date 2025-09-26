output "cluster_uris" {
  value = {
    for k, c in digitalocean_database_cluster.database_cluster :
    k => c.uri
  }
}

output "user_passwords" {
  value = {
    for k, u in digitalocean_database_user.db_user :
    k => u.password
  }
  sensitive = true
}
