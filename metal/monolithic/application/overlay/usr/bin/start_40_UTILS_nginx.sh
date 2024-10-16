#!/bin/bash

set -e

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

#################

/usr/sbin/nginx &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "$pid"
