resource "google_container_cluster" "primary" {
  name      = "gke-cluster"
  location  = "us-east4"

  # allows for nodes to be recreated without recreating the cluster
  initial_node_count        = 1
  remove_default_node_pool  = true
}

resource "google_container_node_pool" "primary_nodes" {
  name        = "node-pool"
  location    = "us-east4"
  cluster     = google_container_cluster.primary.name
  node_count  = 1

  node_config {
    preemptible         = true
    machine_type        = "e2-medium"

    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}