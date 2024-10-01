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

# wait for xorg server 
readiness_xorg

# start pipewire 
pipewire &

# start wireplumber 
wireplumber &

# start pipewire-pulse 
pipewire-pulse &

#################

# WAIT FOR CHILD PROCESS:
wait 
