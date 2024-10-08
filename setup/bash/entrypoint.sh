#!/bin/bash

# Set the script directory to the current directory
SCRIPT_DIR=$(dirname "$0")

# Find all scripts with the format *_get_*.sh, sort them, and execute in order
find "$SCRIPT_DIR" -name "*_get_*.sh" | sort | while read -r script; do
    echo "Executing: $script"
    bash "$script" || {
        echo "Error executing $script. Exiting."
        exit 1
    }
done

echo "All scripts executed successfully."
