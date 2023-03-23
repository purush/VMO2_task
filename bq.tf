resource "google_bigquery_dataset" "vmo2_tech_test_bq" {
  dataset_id                  = "vmo2_tech_test"
  friendly_name               = "vmo2 data set"
  description                 = "vmo2 bq data set"
  location                    = "europe-west2"
  default_table_expiration_ms = 3600000
}

module "bq_access_data_editor" {
  source               = "./modules/bq_dataset_access"
  bq_data_set_id       = google_bigquery_dataset.vmo2_tech_test_bq.dataset_id
  bq_data_set_role     = "roles/bigquery.dataEditor"
  bq_access_user_email = google_service_account.bq_editor_sa.email
}