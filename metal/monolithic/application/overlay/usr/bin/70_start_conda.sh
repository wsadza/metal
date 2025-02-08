#!/bin/bash

set -e
source /usr/bin/readiness_monitor.sh

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

# continous monitoring - pulse
while true; do sleep 5 && readiness_conda; done &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "${pid}"
