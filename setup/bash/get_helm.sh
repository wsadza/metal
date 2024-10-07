#!/bin/bash

# Prerequisites
echo "Installing prerequisites..."
apt-get update
apt-get install -y curl gnupg software-properties-common apt-transport-https

# GPG Key
echo "Downloading and installing Helm GPG key..."
curl https://baltocdn.com/helm/signing.asc | tee /usr/share/keyrings/helm.asc > /dev/null

# APT Repository
echo "Adding Helm APT repository..."
echo "deb [signed-by=/usr/share/keyrings/helm.asc] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-d
ebian.list

# Package Installation
echo "Updating package cache and installing Helm..."
apt-get update
apt-get install -y helm
