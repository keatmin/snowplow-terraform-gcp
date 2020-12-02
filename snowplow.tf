module "snowplow_collector" {
  source      = "./modules/snowplow_collector"
  name        = var.collector_name
  network     = var.network
  domain      = var.collector_domain
  environment = var.environment
  machine_type= var.collector_machine_type
}

module "snowplow_tracker" {
  source = "./modules/snowplow_tracker"
}

module "snowplow_enrich" {
  source      = "./modules/snowplow_enrich"
  name        = var.enrich_name
  network     = var.network
  environment = var.environment
  machine_type = var.enrich_machine_type
  bq_location = var.enrich_bq_location
}
