#! /bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

curl https://s3-eu-west-1.amazonaws.com/snowplow-hosted-assets/third-party/ua-parser/regexes-latest.yaml --output regexes-latest.yaml
curl https://s3-eu-west-1.amazonaws.com/snowplow-hosted-assets/third-party/referer-parser/referers-latest.json --output referers-latest.json
