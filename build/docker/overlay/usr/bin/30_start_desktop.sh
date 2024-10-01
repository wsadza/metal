#!/bin/bash

set -e
source /usr/bin/readiness_monitor.sh

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

#################

# wait for xorg server 
readiness_xorg

# execute kde plasma
/usr/bin/startplasma-x11 &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "$pid"
