#!/usr/bin/env bash

is_ready() {
     curl -s --include --header "X-Project-ID: 000" \
        http://localhost:8888/v1.0/ping \
        | grep "204 No Content" \
        | wc -l \
        | sed 's/ //g'
}

while [[ ! "$(is_ready)" = "1" ]]; do
  echo "$(date) - Waiting for poppy-server to come online"
  sleep 1
done
echo "$(date) - Connected!"


# "Upsert" sni config
python /poppy/scripts/providers/akamai/san_cert_info/cassandra/upsert_sni_cert_info.py --config-file /etc/poppy.conf


# Create a default flavors
curl --include \
     --request POST \
     --header "Content-Type: application/json" \
     --header "X-Project-ID: 000" \
     --data-binary '{"id": "cdn", "limits": [{"origins": {"min": 1, "max": 5}, "domains": {"min": 1, "max": 5}, "caching": {"min": 3600, "max": 604800, "incr": 300}}], "providers": [{"provider": "akamai", "links": [{"href": "http://www.akamai.com", "rel": "provider_url"}]}]}' \
     "http://localhost:8888/v1.0/flavors"

# Create a default flavors
curl --include \
     --request POST \
     --header "Content-Type: application/json" \
     --header "X-Project-ID: 000" \
     --data-binary '{"id": "flavor", "limits": [{"origins": {"min": 1, "max": 5}, "domains": {"min": 1, "max": 5}, "caching": {"min": 3600, "max": 604800, "incr": 300}}], "providers": [{"provider": "akamai", "links": [{"href": "http://www.akamai.com", "rel": "provider_url"}]}]}' \
     "http://localhost:8888/v1.0/flavors"
