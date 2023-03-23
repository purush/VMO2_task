resource "google_bigquery_dataset_access" "access" {
  dataset_id    = var.bq_data_set_id
  role          = var.bq_data_set_role
  user_by_email = var.bq_access_user_email
}