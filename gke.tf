
resource "google_container_cluster" "primary" {
  name     = var.my_gke_cluster
  location = var.region
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc.name
  subnetwork               = google_compute_subnetwork.subnet.name
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  node_config {
    service_account = google_service_account.gke-provisioning-sa.email
    disk_type       = "pd-ssd"
    disk_size_gb    = 10
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_cidr_block
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.pod_cidr_block
    services_ipv4_cidr_block = var.service_cidr_block
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.subnet_cidr_block
      display_name = "internal"
    }
  }

}


resource "google_container_node_pool" "pool1_autoscale_preemptible_nodes" {
  name    = "pool1-autoscaling-preemptible"
  cluster = google_container_cluster.primary.id
  autoscaling {
    max_node_count = 4
    min_node_count = 0 // Note Min should be > 0
  }
  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_type    = "pd-ssd"
    disk_size_gb = 10
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke-provisioning-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}


resource "google_container_node_pool" "pool2_nodes" {
  name       = "pool2-no-scaling"
  cluster    = google_container_cluster.primary.id
  node_count = 1
  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    disk_type    = "pd-ssd"
    disk_size_gb = 10
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke-provisioning-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
