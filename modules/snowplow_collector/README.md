# Snowplow

## Setup
[Setup guide link](https://github.com/snowplow/snowplow/wiki/GCP:-Setting-up-the-Scala-Stream-Collector#4b-2-via-the-command-line)

As snowplow keeps getting new updates, check to see if the config file is up to date here:
 [Scale collector's config file](https://github.com/snowplow/snowplow/blob/master/2-collectors/scala-stream-collector/examples/config.hocon.sample)
 [Blog on configuration](https://snowplowanalytics.com/blog/2020/09/07/pipeline-configuration-for-complete-and-accurate-data/#config)

### Cookie Settings
- To learn about what the config means refer to this [link](https://github.com/snowplow/snowplow/wiki/Configure-the-Scala-Stream-Collector)
- To allow multiple domains to use the cookie from the original site, set `domains` and `fallbackDomain` to allow different applications to use the domain's cookie. This is important to ensure same users entering different domain has the same `did`

 After setting up, there's still a need to go to your DNS provider to have the `A` config pointing to the output ip address
