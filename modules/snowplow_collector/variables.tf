variable "environment" {
  type        = string
  description = "Environment of project"
  default     = "dev"
}

variable "project_id" {
  type        = map(string)
  description = "Project ID of GCP project"
}

variable "collected_good" {
  description = "pubsub topic and subscription for good data"
  default = {
    name         = "collected-good"
    subscription = "collected-good-sub"
  }
}
variable "collected_bad" {
  description = "pubsub topic and subscription for bad data"
  default = {
    name         = "collected-bad"
    subscription = "collected-bad-sub"
  }
}

variable "name" {
  type = string
}

variable "service_port" {
  type    = number
  default = 8080
}

variable "network" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "domain" {
  type        = string
  description = "SSL domain to be used"
}
