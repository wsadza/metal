#!/bin/bash

#------------------------------------
# Supervisord logs

SUPERVISOR_PATH_LOGS="${XDG_RUNTIME_DIR}/logs"

# Create the log directory if it doesn't exist
if ! mkdir -p "${SUPERVISOR_PATH_LOGS}"; then
    echo "Failed to create directory: ${SUPERVISOR_PATH_LOGS}" >&2
    exit 1
fi

# Change permissions 
chown -R ${SUDO_USER} ${SUPERVISOR_PATH_LOGS}

#------------------------------------
# Supervisord Config 

SUPERVISOR_PATH_CONFIG="/etc/supervisord.conf"

gomplate -o ${SUPERVISOR_PATH_CONFIG} << 'EOF'
{{- if has .Env "SUPERVISOR_PORT" }}
[inet_http_server]
port=0.0.0.0:{{ default "9001" .Env.SUPERVISOR_PORT }}

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface
{{- end }}

[unix_http_server]
file={{ .Env.XDG_RUNTIME_DIR }}/supervisor.sock
chmod=0700

[supervisorctl]
serverurl=unix://{{ .Env.XDG_RUNTIME_DIR }}/supervisor.sock 

[include]
files=/etc/supervisor.d/*.ini

[supervisord]
logfile={{ .Env.XDG_RUNTIME_DIR }}/logs/supervisord.log
logfile_maxbytes=5MB
logfile_backups=0
loglevel=info
pidfile={{ .Env.XDG_RUNTIME_DIR }}/logs/supervisord.pid
childlogdir={{ .Env.XDG_RUNTIME_DIR }}
nodaemon=true
user={{ .Env.SUDO_USER }}
environment=

{{- if has .Env "PRIME_RENDERER_GLOBAL" }}
{{- if eq .Env.PRIME_RENDERER_GLOBAL "true" }}
  __GLX_VENDOR_LIBRARY_NAME=nvidia
{{- end }}
{{- end }}
EOF

# Change config permission 
chmod -R a+rwX ${SUPERVISOR_PATH_CONFIG}
chown -R ${SUDO_USER} ${SUPERVISOR_PATH_CONFIG}
