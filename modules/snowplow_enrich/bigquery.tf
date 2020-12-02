locals {
  name = "snowplow"
}

resource "google_bigquery_dataset" "snowplow_dataset" {
  dataset_id    = local.name
  friendly_name = local.name
  description   = "Dataset for snowplow events"
  location      = var.bq_location


  labels = {
    project = local.name
  }

}
