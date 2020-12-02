variable "environment" {
  type        = string
  description = "Environment of project"
  default     = "dev"
}

variable "project_id" {
  type        = map(string)
  description = "Project ID of GCP project"
}

variable "region" {
  type        = string
  description = "Region of GCP Project"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "Zone of GCP Project"
  default     = "us-east1-b"
}

variable "network" {
  type        = string
  description = "VPC network name to put deployment"
}

variable "enrich_name" {
  type        = string
  description = "Snowplow enrich name"
}

variable "collector_name" {
  type        = string
  description = "Snowplow collector name"
}

variable "collector_domain" {
  type        = string
  description = "Snowplow collector domain name"
}

variable "enrich_machine_type" {
  type        = string
  description = "GCE instance type for enrich"
}

variable "enrich_bq_location" {
  type        = string
  description = "Location of BigQuery dataset to create"
}

variable "collector_machine_type" {
  type        = string
  description = "GCE instance type for collector"
}
