#!/bin/bash

set -e

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

#################

# Start supervisord-exporter
exec /usr/bin/supervisord-exporter \
  -supervisord-url="${SUPERVISORD_URL}" \
  -web.listen-address=":${SUPERVISORD_METRICS_PORT}" \
  -web.telemetry-path="${SUPERVISORD_METRICS_PATH}" \
  &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "$pid"
