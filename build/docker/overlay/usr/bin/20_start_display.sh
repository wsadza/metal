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

rm -rf "/tmp/.X*"

# Allow connections to xorg server 
# Simply use DISPLAY=host:0 glxgears
# xhost +

# Start virtual display
/usr/bin/Xvfb "${DISPLAY}" \
  -screen 0 \
  "${DISPLAY_SIZE_X}x${DISPLAY_SIZE_Y}x${DISPLAY_CDEPTH}" \
  -dpi "${DISPLAY_DPI}" \
  +extension "COMPOSITE" \
  +extension "DAMAGE" \
  +extension "GLX" \
  +extension "RANDR" \
  +extension "RENDER" \
  +extension "MIT-SHM" \
  +extension "XFIXES" \
  +extension "XTEST" \
  +iglx \
  +render \
  -listen "tcp" \
  -ac \
  -noreset \
  -shmem &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "${pid}"
