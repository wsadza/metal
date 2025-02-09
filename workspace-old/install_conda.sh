
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda

rm -f Miniconda3-latest-Linux-x86_64.sh

/opt/conda/bin/conda init bash

source /opt/conda/bin/activate

# Set the environment variable to prevent prompting
export CONDA_EXCLUDE_TIKZ=1

# Create the environment
conda create -n eleven python=3.11 -y;

# # Activate the environment
# source /opt/conda/bin/activate eleven;

# Make the 'eleven' environment the default
# Activate the environment
conda activate eleven;

# Make the 'eleven' environment the default
# conda activate eleven;

pip install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia;
