## Setting up snowplow_enrich
The technical documentation and [setup guide](https://github.com/snowplow/snowplow/wiki/setting-up-beam-enrich)

1. [List of schema](https://github.com/snowplow/iglu-central/tree/master/schemas)
2. [Enrichments](https://github.com/snowplow/snowplow/wiki/Configurable-enrichments)
3. Change Dataflow specific settings for `beam-enrich` based on documentation by [Google Dataflow](https://cloud.google.com/dataflow/docs/guides/specifying-exec-params#python_10)
4. [Resolver's settings](https://github.com/snowplow/iglu/wiki/Iglu-client-configuration)

### Dataflow specific settings
```
    --runner=DataFlowRunner which specifies that we want to run on Dataflow
    --project={project}, the name of the GCP project
    --streaming=true to notify Dataflow that we're running a streaming application
    --zone=europe-west2-a, the zone where the Dataflow nodes (effectively GCP Compute Engine nodes) will be launched
    --region=europe-west2, the region where the Dataflow job will be launched
    --gcpTempLocation=gs://location/, the GCS bucket where temporary files necessary to run the job (e.g. JARs) will be stored
```


## TODO
- Using Docker to start the `beam-enrich` service
