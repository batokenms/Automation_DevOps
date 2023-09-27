#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Install net-tools package if netstat is not available
if ! command -v netstat &> /dev/null; then
    echo "netstat is not installed. Installing net-tools package..."
    apt update
    apt install -y net-tools
fi

# Use netstat to check for the system using port 8080
result=$(netstat -tuln | grep ":8080")

if [ -n "$result" ]; then
    echo "Port 8080 is in use on the following system(s):"
    echo "$result"
else
    echo "Port 8080 is not in use on any system."
fi
