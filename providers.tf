terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  version = "3.38.0"
  project = var.project_id[var.environment]
  region  = var.region
  zone    = var.zone
}
