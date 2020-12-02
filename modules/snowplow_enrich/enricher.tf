resource "google_compute_address" "collector_static_ip" {
  name = var.name
}

resource "google_compute_firewall" "enricher_firewall" {
  name        = "allow-ingress-from-iap"
  description = "Firewall protocol for enricher VM"
  direction   = "INGRESS"
  network     = var.network
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags   = []
  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_instance_template" "enricher" {
  name         = "enricher"
  machine_type = var.machine_type
  tags         = [var.name]


  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    disk_size_gb = 20
    boot         = true
  }

  network_interface {
    network = var.network
    access_config {
      nat_ip       = google_compute_address.collector_static_ip.address
      network_tier = "PREMIUM"
    }
  }

  service_account {
    scopes = ["pubsub", "storage-rw", "bigquery", "compute-rw"]
  }

  metadata_startup_script = file("${path.module}/config/startup_script.sh")
  labels = {
    project = "snowplow",
    env     = var.environment

  }
}

resource "google_compute_instance_group_manager" "enricher_instance_group" {
  name = "${var.name}-group"

  base_instance_name = "${var.name}-group"

  version {
    instance_template = google_compute_instance_template.enricher.id
  }

  target_size = 1

  auto_healing_policies {
    health_check      = google_compute_health_check.snowplow_enricher_health_check.id
    initial_delay_sec = 300
  }

  depends_on = [
    google_storage_bucket.snowplow_enricher_bucket
  ]
}

resource "google_compute_health_check" "snowplow_enricher_health_check" {
  name = "${var.name}-health-check"

  timeout_sec         = 5
  check_interval_sec  = 10
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    request_path = "/health"
    port         = 80
  }
}
