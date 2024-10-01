#!/bin/bash
# https://nektosact.com/usage/index.html

# ----
cat << EOF > /tmp/act_secrets
SECRET_GITHUB_TOKEN=""
EOF
# ----
act \
  workflow_dispatch \
  --eventpath /tmp/act_payload \
  --secret-file /tmp/act_secrets \
  --verbose \
  --job ansible
