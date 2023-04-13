resource "google_bigquery_dataset" "vmo2_tech_test_bq" {
  dataset_id                  = "vmo2_tech_test"
  friendly_name               = "vmo2 data set"
  description                 = "vmo2 bq data set"
  location                    = "europe-west2"
  default_table_expiration_ms = 3600000
}

module "bq_access_data_editor" {
  for_each = local.role_data_set_id
  source               = "./modules/bq_dataset_access"
  bq_data_set_id       = each.value["id"]
  bq_data_set_role     = each.value["role"]
  bq_access_user_email = each.value["email"]
}

locals {
  role_data_set_id = {
    "sa-editor" = {
    id = google_bigquery_dataset.vmo2_tech_test_bq.dataset_id 
    role = "roles/bigquery.dataEditor"
    email =  google_service_account.bq_editor_sa.email
    }
  }
}