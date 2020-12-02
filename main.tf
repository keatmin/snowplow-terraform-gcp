resource "google_compute_network" "snowplow_vpc" {
  name = var.network
}

resource "google_project_service" "snowplow" {
  for_each = toset([
    "pubsub.googleapis.com",
    "compute.googleapis.com",
    "dataflow.googleapis.com"
  ])

  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = false
}
