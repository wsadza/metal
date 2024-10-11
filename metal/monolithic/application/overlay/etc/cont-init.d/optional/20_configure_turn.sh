#!/bin/bash

# Skip turn in case of remote turn instance 
if [ ! -z "${SELKIES_TURN_HOST}" ]; then
  exit 0
fi

# Enable turn service in supervisord 
sed -i \
  's/autostart=false/autostart=true/' \
  /etc/supervisor.d/*turn.ini

#------------------------------------
# Create sqlite-turn database 

mkdir -p "${XDG_RUNTIME_DIR}/turn"

#------------------------------------
# Create coturn config 

COTURN_PATH_CONFIG="/etc/turnserver.conf"

#gomplate -o "${COTURN_PATH_CONFIG}" << 'EOF'
cat <<EOF > "${COTURN_PATH_CONFIG}"
# Enable verbose logging
verbose

# IP address and ports
listening-ip=0.0.0.0
listening-ip=::
listening-port=${TURN_PORT}

# Daemonize the process (run in background)
fingerprint

# Enable long-term credentials mechanism
lt-cred-mech

# Specify TURN username and password
user=${TURN_USERNAME}:${TURN_PASSWORD}
cli-password=${TURN_PASSWORD}

# Specify the realm (usually the domain)
realm=${TURN_REALM}

# Min and Max ports for relay traffic
min-port=${TURN_MIN_PORT}
max-port=${TURN_MAX_PORT}

# Loopback and database
userdb=${XDG_RUNTIME_DIR}/turn/turndb

# Optionally, listen on specific IPs or interfaces
listening-port=${TURN_PORT}

# PID and logging
pidfile=${XDG_RUNTIME_DIR}/turnserver.pid
EOF

# Change config permissions
chmod -R a+rwX ${COTURN_PATH_CONFIG}
chown -R ${SUDO_USER} ${COTURN_PATH_CONFIG}
