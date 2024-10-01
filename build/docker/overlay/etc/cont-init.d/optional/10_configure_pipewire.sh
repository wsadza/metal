#!/bin/bash

# Skip pipewire configuration in case of remote 
if [ "${PULSE_SERVER}" != "unix:${XDG_RUNTIME_DIR}/pulse-server" ]; then
  # Use sed to change autostart=true to autostart=false in all *_turn.ini files
  sed -i 's/autostart=true/autostart=false/' /etc/supervisor.d/*sound.ini
  exit 0
fi

# Define the directory and configuration file variables
PIPEWIRE_CONF_DIR="/usr/share/pipewire/pipewire.conf.d/"
PIPEWIRE_CONF_PULSE="module-protocol-pulse.conf"

# Create the configuration directory if it doesn't exist
if ! mkdir -p "${PIPEWIRE_CONF_DIR}"; then
    echo "Failed to create directory: ${PIPEWIRE_CONF_DIR}" >&2
    exit 1
fi

# Write the configuration to the specified file
cat <<EOF > "${PIPEWIRE_CONF_DIR}${PIPEWIRE_CONF_PULSE}"
context.modules = [

    { name = libpipewire-module-protocol-pulse
      args = {
          server.address = [
              "unix:${XDG_RUNTIME_DIR}/pulse-server"
              "tcp:${PIPEWIRE_PORT:=4713}"
          ]
          default.clock.quantum       = 32
          default.clock.min-quantum   = 16
          default.clock.max-quantum   = 768
          server.dbus-name            = "org.pulseaudio-pipewire.Server"
      }
    }
]
EOF
