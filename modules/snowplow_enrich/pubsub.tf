
locals { project_name = "snowplow" }

resource "google_pubsub_topic" "enriched_good" {
  name = var.enriched_good.name

  labels = {
    project = local.project_name
  }
}

resource "google_pubsub_topic" "enriched_bad" {
  name = var.enriched_bad.name

  labels = {
    project = local.project_name
  }
}

resource "google_pubsub_topic" "bq_types" {
  name = var.bq_types.name

  labels = {
    project = local.project_name
  }
}

resource "google_pubsub_topic" "bq_bad_rows" {
  name = "bad-rows"

  labels = {
    project = local.project_name
  }
}

resource "google_pubsub_topic" "bq_failed_inserts" {
  name = "bq-failed-inserts"

  labels = {
    project = local.project_name
  }
}

resource "google_pubsub_subscription" "enriched_good_sub" {
  name  = var.enriched_good.subscription
  topic = google_pubsub_topic.enriched_good.id

  labels = {
    project = local.project_name
  }

}

resource "google_pubsub_subscription" "enriched_bad_sub" {
  name  = var.enriched_bad.subscription
  topic = google_pubsub_topic.enriched_bad.id

  labels = {
    project = local.project_name
  }
}

resource "google_pubsub_subscription" "bq_types_sub" {
  name  = var.bq_types.subscription
  topic = google_pubsub_topic.bq_types.id

  labels = {
    project = local.project_name
  }
}
