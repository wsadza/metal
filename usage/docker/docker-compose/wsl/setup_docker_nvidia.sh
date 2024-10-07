# Install docker / docker-compose / nvidia-container-toolkit
#!/bin/bash
# Add i386 architecture support
sudo dpkg --add-architecture i386;
# Add NVIDIA container toolkit GPG key and repository
sudo apt-get install gnupg gnupg2;
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
# Update package lists
sudo apt-get update
# Install required packages
sudo apt-get install -y \
  docker.io \
  docker-compose \
  nvidia-container-toolkit
# Configure NVIDIA container toolkit for Docker
sudo nvidia-ctk runtime configure --runtime=docker
# Restart Docker service to apply changes
sudo systemctl restart docker
