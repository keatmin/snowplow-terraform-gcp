#! /bin/bash
sudo apt-get update
sudo apt-get -y install default-jre
sudo apt-get -y install unzip
archive=snowplow_scala_stream_collector_google_pubsub_1.0.1.zip
wget https://dl.bintray.com/snowplow/snowplow-generic/$archive
gsutil cp gs://{bucket-name-in-storagetf}/application.config .
unzip $archive
java -jar snowplow-stream-collector-google-pubsub-1.0.1.jar --config application.config &
