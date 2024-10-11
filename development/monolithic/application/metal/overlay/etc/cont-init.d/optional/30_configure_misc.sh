#!/bin/bash

#------------------------------------
# Use Nvidia-GPU to render all applications
#

# Check nvidia-gpu avilibility
# 
if ! command -v nvidia-smi > /dev/null 2>&1; then
  exit 0;
fi

# Use gpu to render all applications
# 
if [ "${PRIME_RENDERER_GLOBAL}" == "true" ]; then

cat <<EOF >> /etc/bash.bashrc
export __GLX_VENDOR_LIBRARY_NAME=nvidia 
EOF

cat <<EOF >> /etc/environment
__GLX_VENDOR_LIBRARY_NAME=nvidia 
EOF

fi

# Use gpu to render only wine applications
# 
if [ "${PRIME_RENDERER_WINE}" == "true" ]; then
cat <<EOF >> /etc/bash.bashrc
alias wine='__GLX_VENDOR_LIBRARY_NAME=nvidia wine'
EOF
fi
