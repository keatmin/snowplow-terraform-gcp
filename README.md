## To authenticate

1. Install gcloud sdk on your computer
2. Run `gcloud init` to setup your gcloud sdk on your terminal

To obtain OAuth before running `terraform apply` run below to obtain a 1 hour token

```
export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token)
terraform apply
```

[Guide on accurate tracking](https://docs.snowplowanalytics.com/wp-content/uploads/2020/09/Cookie-config-calculator-Open-Source.pdf)

## Items to fill
1. Variables in tfvars
2. Fill up projectId in `modules/snowplow_collector/config/application.config` and bucket_name in `modules/snowplow_collector/config/startup_script.sh`
3. Variables in `modules/snowplow_enrich/config/startup_script.sh`. If unsure about version number, find the latest version from [here](https://dl.bintray.com/snowplow/snowplow-generic/)
4. Ensure enrichments in `modules/snowplow_enrich/config` is properly filled if planning to use, i.e `referer_parser.json` and `bigquery_config.json`
