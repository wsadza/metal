#!/bin/bash

# Gather system facts
echo "Gathering system information..."
uname -a

# Presence Check for NVIDIA
echo "Checking for NVIDIA presence..."
if ! command -v nvidia-smi &> /dev/null; then
    echo "NVIDIA not found. Proceeding with installation."

    # Get the latest NVIDIA download URL
    echo "Fetching the latest NVIDIA download URL..."
    nvidia_url_output=$(curl -s -X GET https://download.nvidia.com/XFree86/Linux-x86_64/latest.txt)

    if [ -z "$nvidia_url_output" ]; then
        echo "Failed to fetch the NVIDIA download URL."
        exit 1
    fi

    # Fetch latest Nvidia driver
    echo "Downloading the latest NVIDIA driver..."
    driver_url="https://download.nvidia.com/XFree86/$nvidia_url_output"
    wget -O /tmp/nvidia.run "$driver_url"
    chmod 0755 /tmp/nvidia.run

    # Install latest Nvidia driver
    echo "Installing the NVIDIA driver..."
    /tmp/nvidia.run --silent --install-compat32-libs
    install_output=$?

    if [ $install_output -eq 0 ]; then
        echo "NVIDIA driver installed successfully."
    else
        echo "NVIDIA driver installation failed."
        exit $install_output
    fi
else
    echo "NVIDIA is already installed."
fi

