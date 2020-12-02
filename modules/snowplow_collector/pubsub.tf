locals { project_name = "snowplow" }



resource "google_pubsub_topic" "collector_good" {
  name = var.collected_good.name

  labels = {
    project = local.project_name
  }
}

resource "google_pubsub_topic" "collector_bad" {
  name = var.collected_bad.name

  labels = {
    project = local.project_name
  }
}

resource "google_pubsub_subscription" "collected_good_sub" {
  name  = var.collected_good.subscription
  topic = google_pubsub_topic.collector_good.id

  labels = {
    project = local.project_name
  }

}

resource "google_pubsub_subscription" "collected_bad_sub" {
  name  = var.collected_bad.subscription
  topic = google_pubsub_topic.collector_bad.id

  labels = {
    project = local.project_name
  }
}
