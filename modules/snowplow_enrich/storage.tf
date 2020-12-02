resource "google_storage_bucket" "snowplow_enricher_bucket" {
  name          = "sp-${var.name}-temp"
  force_destroy = true
}

resource "google_storage_bucket_object" "temp_folder" {
  name    = "temp-files/"
  content = "Temp files"
  bucket  = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "resolver" {
  name   = "iglu_resolver.json"
  source = "${path.module}/config/iglu_resolver.json"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "bigquery_config" {
  name   = "bigquery_config.json"
  source = "${path.module}/config/bigquery_config.json"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "campaign_attribution" {
  name   = "campaign_attribution.json"
  source = "${path.module}/config/campaign_attribution.json"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "ip_lookups" {
  name   = "ip_lookups.json"
  source = "${path.module}/config/ip_lookups.json"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "referer_parser" {
  name   = "referer_parser.json"
  source = "${path.module}/config/referer_parser.json"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "ua_parser_config" {
  name   = "ua_parser_config.json"
  source = "${path.module}/config/ua_parser_config.json"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "geolite-db" {
  name   = "GeoLite2-City.mmdb"
  source = "${path.module}/config/GeoLite2-City.mmdb"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}
resource "google_storage_bucket_object" "regexes-ua-parser" {
  name   = "regexes-latest.yaml"
  source = "${path.module}/config/regexes-latest.yaml"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "referers-latest" {
  name   = "referers-latest.json"
  source = "${path.module}/config/referers-latest.json"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}

resource "google_storage_bucket_object" "cookie_extractor_config" {
  name   = "cookie_extractor_config.json"
  source = "${path.module}/config/cookie_extractor_config.json"
  bucket = google_storage_bucket.snowplow_enricher_bucket.name
}
