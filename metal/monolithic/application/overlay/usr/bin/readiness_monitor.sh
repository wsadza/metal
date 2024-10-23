#!/bin/bash

# Time to wait for each service to become ready (in seconds)
TIMEOUT=30

# -----------------------------------------------
# Function to monitor DBus
#
readiness_dbus() {
    echo "Checking DBus status..."
    timeout $TIMEOUT bash -c '
        while ! dbus-send \
                  --type=method_call \
                  --dest=org.freedesktop.DBus \
                  --print-reply /org/freedesktop/DBus \
                  org.freedesktop.DBus.ListNames \
                  > /dev/null 2>&1
        do
            sleep 1
        done
    ' || { echo "DBus did not become ready in time."; exit 1; }
    echo "DBus is ready."
}

# -----------------------------------------------
# Function to monitor Xorg
#
readiness_xorg() {
    echo "Checking Xorg status..."
    timeout $TIMEOUT bash -c '
        while ! xdpyinfo \
                > /dev/null 2>&1
        do
            sleep 1
        done
    ' || { echo "Xorg did not become ready in time."; exit 1; }
    echo "Xorg is ready."
}

# -----------------------------------------------
# Function to check presence of Nvidia GPU
# 
readiness_nvidia() {
  echo "Checking NVIDIA GPU presence..."
  timeout $TIMEOUT bash -c '
      while ! nvidia-smi \
              > /dev/null 2>&1
      do
          sleep 1
      done
  ' || { echo "NVIDIA GPU did not become available in time."; return 1; }
  echo "NVIDIA GPU is present and ready."
}

# -----------------------------------------------
# Function to check conectivity to pulse server
# 
readiness_pulse() {
  echo "Checking PulseAudio server connectivity..."
  timeout $TIMEOUT bash -c '
      while ! pactl info \
              > /dev/null 2>&1
      do
          sleep 1
      done
  ' || { echo "PulseAudio server did not become available in time."; exit 1; }
  echo "PulseAudio server is reachable and ready."
}

# -----------------------------------------------
# Function to check conectivity to turn server
# 
readiness_turn() {
  echo "Checking Turn server connectivity..."
  # Check if turn server is arleady exposed;
  
  # Use internal turn server in case of lack of remote setting 
  if [ -z "${SELKIES_TURN_HOST}" ]; then
    export SELKIES_TURN_HOST="${STREAMER_HOST:=localhost}"
  fi

  timeout $TIMEOUT bash -c '
    while ! turnutils_uclient -y \
              -u '${SELKIES_TURN_USERNAME}' \
              -w '${SELKIES_TURN_PASSWORD}'
              -p '${SELKIES_TURN_PORT}' \
              '${SELKIES_TURN_HOST}' \
            > /dev/null 2>&1
    do
        sleep 1
    done
  ' || { 
    echo "Turn server did not become available in time."; 
    exit 1; 
  }
  echo "Turn server is reachable and ready."
}

# -----------------------------------------------
# Function to obtain remote address 
# (which client is using to reach server) 
# 
obtaining_remote_address() {
  echo "Checking external address..."
  # Set the timeout in seconds (e.g., 15 seconds)
  TIMEOUT_DURATION=15

  # Run socat with a timeout
  timeout ${TIMEOUT_DURATION} socat TCP-LISTEN:${SELKIES_PORT},fork - 2>/dev/null | {
    while IFS= read -r line; do
      echo "$line" \
        | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}|[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' \
        > /tmp/server_address \
        && break
    done
  }

  # If timeout occurs and the process is not terminated, send pkill
  if [ $? -eq 124 ]; then
    echo "Timeout reached. Terminating socat process."
    pkill socat
  fi
}
