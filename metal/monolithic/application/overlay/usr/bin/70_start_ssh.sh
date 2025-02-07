#!/bin/bash

set -e
source /usr/bin/readiness_monitor.sh

# Function to handle termination signals
_term() {
    echo "Terminating SSH service..."
    sudo systemctl stop ssh
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

#################

echo "Starting SSH service..."

# Start SSH daemon
sudo service ssh start

# Check if SSH is running
if [[ $(sudo service ssh status) =~ "running" ]]; then
    echo "SSH service is running."
else
    echo "Failed to start SSH service." >&2
    exit 1
fi

# Continous monitoring - SSH
# while true; do
#     sleep 5
#     readiness_ssh || echo "SSH service is not ready."
# done &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "${pid}"
