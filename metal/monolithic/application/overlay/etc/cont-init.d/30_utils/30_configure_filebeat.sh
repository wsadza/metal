#!/bin/bash

# Skip turn in case of external proxy instance 
if [ "${FILEBEAT_LOGGER_ENABLED}" = "false" ]; then
  exit 0
fi

sed -i \
  's/autostart=false/autostart=true/' \
  /etc/supervisor.d/*_filebeat.ini

FILEBEAT_PATH_CONFIG="/etc/filebeat/filebeat.yml"

cat <<EOF > "${FILEBEAT_PATH_CONFIG}"
logging.level: error
logging.metrics.enabled: false

filebeat.inputs:
  - type: filestream
    enabled: true
    id: metal 
    paths:
      - /run/user/1000/logs/log_*
    encoding: utf-8
    exclude_files: 
      - '\.log_dbus'

outputconsole.enabled: true
output.console.pretty: true 

processors:

# Extract process name from log path file, 
# and put it as separate key in final log
# eg. /run/user/1000/logs/log_dbus -> dbus
  - script:
      when:
        has_fields: ["log.file.path"]
      lang: javascript
      id: extract_stream
      source: >
        function process(event) {
          var logPath = event.Get("log.file.path");
          var parts = logPath.split("/");
          // Extract the last part after 'log_' in the path
          var extractedValue = parts[parts.length - 1].replace("log_", "");
          event.Put("process", extractedValue);
          // Get Message
          //var originalMessage = event.Get("message");
          //event.Put("message", "[" + extractedValue + "]:" + originalMessage)
        }

# Filbeats - remove ansi control characters for colored logs
# ~ https://gist.github.com/TheCase/b0389757fb58fe45244317042a3405f0
  - script:
       when:
         regexp:
           message: "[\u001b\u009b][[()#;?]*(?:[0-9]{1,4}(?:;[0-9]{0,4})*)?[0-9A-ORZcf-nqry=><]"
       lang: javascript
       id: remove_ansi_color
       source: >
         function process(event) {
           var msg = event.Get("message")
           var regex = /[\u001b\u009b][[()#;?]*(?:[0-9]{1,4}(?:;[0-9]{0,4})*)?[0-9A-ORZcf-nqry=><]/g
           event.Put("message", msg.replace(regex, ''))
           event.Tag("ansi_color_removed")
         }

# drop filebeat extra fields
  - drop_fields:
      fields: ["log", "input", "ecs", "host", "agent", "fields"]
EOF

# Change lib permissions
mkdir /var/lib/filebeat
chmod -R a+rwX /var/lib/filebeat 

# Change config permissions
chmod -R a+rwX ${FILEBEAT_PATH_CONFIG}
chown -R ${SUDO_USER} ${FILEBEAT_PATH_CONFIG}
chmod go-w ${FILEBEAT_PATH_CONFIG}
