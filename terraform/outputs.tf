output "cluster_uris" {
  value     = module.database_clusters.cluster_uris
  sensitive = true
}

output "user_passwords" {
  value     = module.database_clusters.user_passwords
  sensitive = true
}
