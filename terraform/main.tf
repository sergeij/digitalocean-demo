terraform {
  required_version = "=1.13.3"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.67.0"
    }
  }
}

provider "digitalocean" {
  token = var.token
}

module "vpc" {
  source = "./modules/do/vpc"

  name     = var.vpc_name
  region   = var.vpc_region
  ip_range = var.vpc_ip_range
}

module "droplets" {
  source = "./modules/do/droplet"

  droplets = var.droplets
  vpc_uuid = module.vpc.vpc_uuid
}

module "firewalls" {
  source = "./modules/do/firewall"

  firewalls = var.firewalls

  depends_on = [
    module.droplets
  ]
}

module "loadbalancers" {
  source = "./modules/do/loadbalancer"

  loadbalancers = var.loadbalancers
  vpc_uuid      = module.vpc.vpc_uuid

  depends_on = [
    module.droplets
  ]
}

module "database_clusters" {
  source = "./modules/do/database_cluster"

  database_clusters = var.database_clusters
}
