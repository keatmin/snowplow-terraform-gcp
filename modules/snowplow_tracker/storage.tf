resource "google_storage_bucket" "snowplow_static_js" {
  name          = "snowplow_static_js"
  force_destroy = true

}

resource "google_storage_bucket_object" "sp_file" {
  name          = "sp.js"
  source        = "${path.module}/config/sp.js"
  bucket        = google_storage_bucket.snowplow_static_js.name
  cache_control = 315360000
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.snowplow_static_js.name
  role   = "READER"
  entity = "allUsers"
}


resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.snowplow_static_js.name
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}
