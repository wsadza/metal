#!/bin/bash

set -e
source /usr/bin/readiness_monitor.sh

# CATCH TERM SIGNAL:
_term() {
    kill -TERM "$pid" 2>/dev/null
}
trap _term SIGTERM SIGINT

# curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda

# rm -f Miniconda3-latest-Linux-x86_64.sh

# /opt/conda/bin/conda init bash;

# source ~/.bashrc && \
# conda activate base && \
# conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia
#
/usr/bin/python3 -m pip install websockets==13

# continous monitoring - pulse
while true; do sleep 5 && readiness_conda; done &

#################

pid=$!

# WAIT FOR CHILD PROCESS:
wait "${pid}"
