#!/bin/bash

set -e

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

#################

dbus-daemon \
  --session \
  --address=unix:path=${XDG_RUNTIME_DIR}/dbus-session \
  --nofork

# continous monitoring - dbus
while true; do sleep 5 && readiness_dbus; done &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "$pid"
