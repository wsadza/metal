#!/bin/bash
set -e

# -------------------------------
# Install Docker (with BuildKit & Buildx)
# -------------------------------
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key and set up the repository
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin

# Add current user to the docker group to run docker without sudo
sudo usermod -aG docker $USER
newgrp docker

# -------------------------------
# Install NVIDIA Container Toolkit
# -------------------------------
# This will add the NVIDIA package repository and install nvidia-docker2.
# Note: Ensure that you already have the appropriate NVIDIA driver installed on your system.

# Set the distribution variable (for Ubuntu 22.04, this will likely be "ubuntu22.04")
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

# Add NVIDIA’s GPG key (stored in a keyring)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo gpg --dearmor -o /usr/share/keyrings/nvidia-docker.gpg

# Add the NVIDIA Docker repository to APT sources
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sed 's#https://#deb [signed-by=/usr/share/keyrings/nvidia-docker.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2

# Restart Docker to complete the installation of NVIDIA Container Toolkit
sudo systemctl restart docker

# -------------------------------
# Test the Setup (Optional)
# -------------------------------
# Running this test container should display your GPU(s) information.
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
