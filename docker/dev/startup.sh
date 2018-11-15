#!/bin/bash


is_ready() {
    curl -s --include --header "X-Project-ID: 000" http://dev-test.drivesrvr.com/v1.0/ping | head -n 1
}
if [[ is_ready == "HTTP/1.1 204 No Content" ]]; then
    echo "WORKS"
else
    echo "Not yet"
fi

# wait until cassandra is ready
while ! is_ready -eq 1
do
  echo "$(date) - still trying to connect to cassandra"
  sleep 1
done
echo "$(date) - connected successfully to cassandra"


# start the poppy-workers
exec poppy-worker > /dev/null 2>&1 &
exec poppy-worker > /dev/null 2>&1 &
exec poppy-worker > /dev/null 2>&1 &
exec poppy-worker > /dev/null 2>&1 &


# start the poppy-server (via uwsgi)
exec poppy-server
