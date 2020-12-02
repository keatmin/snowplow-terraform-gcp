variable "environment" {
  type        = string
  description = "Environment of project"
  default     = "dev"
}

variable "enriched_good" {
  description = "pubsub topic and subscription for good data"
  default = {
    name         = "enriched-good"
    subscription = "enriched-good-sub"
  }
}
variable "enriched_bad" {
  description = "pubsub topic and subscription for bad data"
  default = {
    name         = "enriched-bad"
    subscription = "enriched-bad-sub"
  }
}

variable "bq_types" {
  description = "pubsub topic and subscription for bad data"
  default = {
    name         = "bq-types"
    subscription = "bq-types-sub"
  }
}

variable "name" {
  description = "Name of project"
}

variable "network" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "bq_location" {
  type        = string
  description = "Dataset location of BigQuery dataset"
}
