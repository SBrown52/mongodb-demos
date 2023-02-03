provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}

resource "mongodbatlas_cluster" "cluster" {
  project_id              = var.project_id
  name                    = "cluster-from-terraform" 
  num_shards              = 1
  replication_factor      = 3
  cloud_backup            = true

  //Provider settings
  provider_name               = "AWS"
  provider_instance_size_name = "M10"
  provider_region_name        = "EU-WEST-2"
}


output "connection_strings" {
  value = ["${mongodbatlas_cluster.cluster.connection_strings}"]
}