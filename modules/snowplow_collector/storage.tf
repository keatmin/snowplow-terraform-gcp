resource "google_storage_bucket" "snowplow_collector_bucket" {
  name          = "sp-${var.name}"
  force_destroy = true
}

resource "google_storage_bucket_object" "collector_config" {
  name   = "application.config"
  source = "${path.module}/config/application.config"
  bucket = google_storage_bucket.snowplow_collector_bucket.name
}
