resource "google_compute_address" "collector_static_ip" {
  name = var.name
}

resource "google_compute_firewall" "collector_firewall" {
  name        = "snowplow-firewall-rule"
  description = "Firewall protocol for collector VM"
  direction   = "INGRESS"
  network     = var.network
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags   = [var.name]
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_instance_template" "collector" {
  name         = "collector"
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
    scopes = ["pubsub", "storage-rw"]
  }

  metadata_startup_script = file("${path.module}/config/startup_script.sh")
  can_ip_forward          = true
  labels = {
    project = "snowplow",
    env     = var.environment

  }
}

resource "google_compute_instance_group_manager" "collector_instance_group" {
  name = "${var.name}-group"

  base_instance_name = "${var.name}-group"

  version {
    instance_template = google_compute_instance_template.collector.id
  }

  named_port {
    name = var.name
    port = 8080
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.snowplow_collector_health_check.id
    initial_delay_sec = 300
  }

  depends_on = [
    google_storage_bucket.snowplow_collector_bucket
  ]
}

resource "google_compute_autoscaler" "snowplow-autoscaler" {
  name   = "${var.name}-group"
  target = google_compute_instance_group_manager.collector_instance_group.id

  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}
# Load balancer
resource "google_compute_managed_ssl_certificate" "snowplow_collector_domain" {
  provider = google-beta
  project  = var.project_id[var.environment]

  name = var.name

  managed {
    domains = [var.domain]
  }
}
# Backend service to instance group
resource "google_compute_backend_service" "snowplow_collector_backend" {
  name      = "${var.name}-backend"
  port_name = var.name
  backend {
    group           = google_compute_instance_group_manager.collector_instance_group.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 1
  }
  health_checks = [google_compute_health_check.snowplow_collector_health_check.id]
}

resource "google_compute_health_check" "snowplow_collector_health_check" {
  name = "${var.name}-health-check"

  timeout_sec         = 5
  check_interval_sec  = 10
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = 8080
    request_path = "/health"
  }
}
# Global address on the internet
resource "google_compute_global_address" "snowplow_global_address" {
  name = "${var.name}-address"
}

# HTTP proxy when http forwarding is true
resource "google_compute_target_http_proxy" "snowplow_target_http" {
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.snowplow.self_link
}

resource "google_compute_target_https_proxy" "snowplow_target_https" {
  name             = "${var.name}-https-proxy"
  url_map          = google_compute_url_map.snowplow.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.snowplow_collector_domain.id]
}
# url mapping to backend service
resource "google_compute_url_map" "snowplow" {
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.snowplow_collector_backend.id
}

# Forwarding traffic received at global address to http proxy
resource "google_compute_global_forwarding_rule" "http" {
  name       = var.name
  target     = google_compute_target_http_proxy.snowplow_target_http.id
  ip_address = google_compute_global_address.snowplow_global_address.address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "https" {
  name       = "${var.name}-https"
  target     = google_compute_target_https_proxy.snowplow_target_https.id
  ip_address = google_compute_global_address.snowplow_global_address.address
  port_range = "443"
}
