#!/bin/bash
# https://nektosact.com/usage/index.html

# ----
cat << EOF > /tmp/act_secrets
GITHUB_TOKEN=""
TOKEN=""
EOF
# ----

act \
  --secret-file /tmp/act_secrets \
  --verbose
