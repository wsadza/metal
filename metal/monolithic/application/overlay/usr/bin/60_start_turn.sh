#!/bin/bash

set -e
source /usr/bin/readiness_monitor.sh

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

#################

# Wait for dbus to being ready.
readiness_dbus

# execute coturn server
/usr/bin/turnserver &

# continous monitoring - pulse
while true; do sleep 5 && readiness_turn; done &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "${pid}"
