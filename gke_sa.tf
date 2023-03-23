resource "google_service_account" "gke-provisioning-sa" {
  account_id   = "manage-gke-sa"
  display_name = "Manage GKE Service Account"
  project      = var.project_id
}

resource "google_project_iam_binding" "project" {
  project = var.project_id
  role    = "roles/container.admin"
  members = [
    "serviceAccount:${google_service_account.gke-provisioning-sa.email}"
  ]
}