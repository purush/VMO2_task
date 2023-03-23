resource "google_compute_network" "vpc" {
  name                            = var.vpc
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "subnet" {
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_cidr_block
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_route" "outbound_internet" {
  name             = "egress-internet"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc.name
  next_hop_gateway = "default-internet-gateway"
}


resource "google_compute_router" "router" {
  name    = "${var.vpc}-router"
  region  = var.region
  network = google_compute_network.vpc.name
}

resource "google_compute_router_nat" "nat_router" {
  name                               = "${google_compute_subnetwork.subnet.name}-nat-router"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}


resource "google_compute_firewall" "rules" {
  project     = var.project_id
  name        = "allow-ssh"
  network     = google_compute_network.vpc.name
  description = "Creates firewall for ssh using IAP "
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  direction = "INGRESS"
}