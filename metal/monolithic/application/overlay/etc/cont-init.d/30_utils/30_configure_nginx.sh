#!/bin/bash

# Skip turn in case of external proxy instance 
if [ "${NGINX_PROXY_HELPER_ENABLED}" = "false" ]; then
  exit 0
fi

# Enable nginx service in supervisord 
sed -i \
  's/autostart=false/autostart=true/' \
  /etc/supervisor.d/*_nginx.ini

#------------------------------------
# Nginx Config 

NGINX_PATH_CONFIG="/etc/nginx/nginx.conf"

cat <<EOF > "${NGINX_PATH_CONFIG}"
worker_processes 1;
daemon off;
pid ${XDG_RUNTIME_DIR}/nginx.pid;
error_log /dev/stdout info;

events {
  worker_connections 1024;
}

http {
  access_log /dev/stdout;
  include       mime.types;
  default_type  application/octet-stream;

  proxy_headers_hash_max_size     1024;  
  proxy_headers_hash_bucket_size  128;  

  sendfile on;
  keepalive_timeout  65;

  server {
    listen       80;
    server_name  localhost;

    # ------------------
    # NGINX - status
    # ------------------
    location /proxy-status {
        stub_status on;
        allow all; 
    }
    # ------------------
    # SUPERVISOR - APP
    # ------------------
    location = /supervisor {
      return 301 /supervisor/;
    }
    location ^~ /supervisor/ {
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header Host \$http_x_host;
      proxy_set_header X-NginX-Proxy true;

      proxy_pass http://127.0.0.1:9091/;
      proxy_redirect off;
      proxy_buffering off;

      proxy_set_header Host \$host;  
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
      proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";
    }
    # ------------------
    # SUPERVISOR - Metrics 
    # ------------------
    location = /supervisor-metrics {
      return 301 /supervisor-metrics/;
    }
    location ^~ /supervisor-metrics/ {
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header Host \$http_x_host;
      proxy_set_header X-NginX-Proxy true;

      proxy_pass http://127.0.0.1:9092/metrics;
      proxy_redirect off;
      proxy_buffering off;

      proxy_set_header Host \$host;  
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
      proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";
    }
    # ------------------
    # SELKIES-GSTREAMER 
    # ------------------
    location / {
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header Host \$http_x_host;
      proxy_set_header X-NginX-Proxy true;

      proxy_pass http://127.0.0.1:8080/;
      proxy_redirect off;
      proxy_buffering off;

      proxy_set_header Host \$host;  
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
      proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";
    }
    # ------------------
    # SELKIES-GSTREAMER - Metrics 
    # ------------------
    location = /metrics {
      return 301 /metrics/;
    }
    location ^~ /metrics/ {
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header Host \$http_x_host;
      proxy_set_header X-NginX-Proxy true;

      proxy_pass http://127.0.0.1:9090/;
      proxy_redirect off;
      proxy_buffering off;

      proxy_set_header Host \$host;  
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
      proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";
    }
  }
}
EOF

# Change permissions to nginx lib
chmod -R a+rwX /var/lib/nginx
