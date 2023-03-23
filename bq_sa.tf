resource "google_service_account" "bq_editor_sa" {
  account_id   = "bq-editor-sa"
  display_name = "BQ Data Editor"
  project      = var.project_id
}
