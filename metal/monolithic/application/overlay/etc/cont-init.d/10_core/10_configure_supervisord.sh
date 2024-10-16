#!/bin/bash

#------------------------------------
# Supervisor logs

SUPERVISORD_PATH_LOGS="${XDG_RUNTIME_DIR}/logs"

# Create the log directory if it doesn't exist
if ! mkdir -p "${SUPERVISORD_PATH_LOGS}"; then
    echo "Failed to create directory: ${SUPERVISORD_PATH_LOGS}" >&2
    exit 1
fi
# Change permissions 
chown -R ${SUDO_USER} ${SUPERVISORD_PATH_LOGS}

#------------------------------------
# Supervisor metrics 

# Skip turn in case of external proxy instance 
if [ "${SUPERVISORD_EXPORTER_ENABLED}" = "true" ]; then
sed -i \
  's/autostart=false/autostart=true/' \
  /etc/supervisor.d/*_supervisord_exporter.ini
fi

#------------------------------------
# Supervisor Config 

SUPERVISORD_PATH_CONFIG="/etc/supervisord.conf"

gomplate -o ${SUPERVISORD_PATH_CONFIG} << 'EOF'
{{- if has .Env "SUPERVISORD_PORT" }}
[inet_http_server]
port=0.0.0.0:{{ default "9091" .Env.SUPERVISORD_PORT }}

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
chmod -R a+rwX ${SUPERVISORD_PATH_CONFIG}
chown -R ${SUDO_USER} ${SUPERVISORD_PATH_CONFIG}
