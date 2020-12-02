#! /bin/bash
enrich_version="1.2.3"
bq_version="0.5.0"
bucket_name=""  # sp-${var.name}-temp
project_id=""
region=""
enrichments=("campaign_attribution.json" "ip_lookups.json" "ua_parser_config.json" "referer_parser.json" "cookie_extractor_config.json") # enrichments to add from config
good_sub="collected-good-sub"

sudo apt-get update
sudo apt-get -y install default-jre
sudo apt-get -y install unzip

wget https://dl.bintray.com/snowplow/snowplow-generic/snowplow_beam_enrich_$enrich_version.zip
unzip snowplow_beam_enrich_$enrich_version.zip

wget https://dl.bintray.com/snowplow/snowplow-generic/snowplow_bigquery_loader_$bq_version.zip
unzip snowplow_bigquery_loader_$bq_version.zip

wget https://dl.bintray.com/snowplow/snowplow-generic/snowplow_bigquery_mutator_$bq_version.zip
unzip snowplow_bigquery_mutator_$bq_version.zip

sudo mkdir enrichments

for enrichment in ${enrichments[*]}; do
	sudo gsutil cp gs://$bucket_name/$enrichment ./enrichments/
done

gsutil cp gs://$bucket_name/iglu_resolver.json .
gsutil cp gs://$bucket_name/bigquery_config.json .


./beam-enrich-$enrich_version/bin/beam-enrich --runner=DataFlowRunner --project=$project_id --streaming=true --region=$region --gcpTempLocation=gs://$bucket_name/temp-files --job-name=beam-enrich --raw=projects/$project_id/subscriptions/$good_sub --enriched=projects/$project_id/topics/enriched-good --bad=projects/$project_id/topics/enriched-bad --resolver=iglu_resolver.json --enrichments=enrichments/

./snowplow-bigquery-mutator-$bq_version/bin/snowplow-bigquery-mutator create --config $(cat bigquery_config.json | base64 -w 0) --resolver $(cat iglu_resolver.json | base64 -w 0)

./snowplow-bigquery-mutator-$bq_version/bin/snowplow-bigquery-mutator listen --config $(cat bigquery_config.json | base64 -w 0) --resolver $(cat iglu_resolver.json | base64 -w 0) &

./snowplow-bigquery-loader-$bq_version/bin/snowplow-bigquery-loader --config=$(cat bigquery_config.json | base64 -w 0) --resolver=$(cat iglu_resolver.json | base64 -w 0) --runner=DataFlowRunner --project=$project_id --region=$region --gcpTempLocation=gs://$bucket_name/temp-files --maxNumWorkers=3
