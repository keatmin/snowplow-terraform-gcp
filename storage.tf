resource "google_storage_bucket" "default_bucket" {
  name          = "default_bucket"
  force_destroy = true

}


resource "google_storage_bucket_access_control" "pub" {
  bucket = google_storage_bucket.default_bucket.name
  role   = "READER"
  entity = "allUsers"
}


resource "google_storage_bucket_iam_binding" "bind" {
  bucket = google_storage_bucket.default_bucket.name
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}
