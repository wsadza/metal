#!/bin/bash

set -e
source /usr/bin/readiness_monitor.sh

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

#################

# Use internal turn server in case of lack of remote setting 
if [ -z "${SELKIES_TURN_HOST}" ]; then
  export SELKIES_TURN_HOST="${DOCKER_HOST:=localhost}"
fi

# If nvidia-gpu is not reachable switch encoder to x264enc 
if ! command -v nvidia-smi > /dev/null 2>&1; then
  if [ "${SELKIES_ENCODER}" == "nvh264enc" ]; then
    export SELKIES_ENCODER="x264enc"
  fi
fi

# wait for turn server 
readiness_turn

# wait for pulse server 
readiness_pulse

# wait for xorg server 
readiness_xorg

# initialy resie stream (xrandr) 
/usr/local/bin/selkies-gstreamer-resize "800x600"

# consume gstreamer variables
. /opt/gstreamer/gst-env 

# execute webrtc streamer 
selkies-gstreamer $@ &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "${pid}"
