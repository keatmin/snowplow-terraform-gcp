output "lb_address" {
  value = google_compute_global_address.snowplow_global_address.address
}
