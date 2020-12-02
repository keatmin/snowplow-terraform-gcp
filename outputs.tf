output "vpc_network" {
  value = google_compute_network.snowplow_vpc.self_link
}

output "vpc_name" {
  value = google_compute_network.snowplow_vpc.name
}

output "lb_address" {
  value = module.snowplow_collector.lb_address
}

output "sp_location" {
  value = module.snowplow_tracker.sp_location
}
