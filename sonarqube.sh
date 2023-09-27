#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Perform system updates (patch management)
echo "Performing system updates..."
apt update
apt upgrade -y

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing Docker..."
    apt install -y docker.io
fi

# Start and enable Docker service
echo "Starting and enabling Docker service..."
systemctl start docker
systemctl enable docker

# Open port 9000 if it's not already open
if ! ufw status | grep -q "9000/tcp"; then
    echo "Opening port 9000..."
    ufw allow 9000/tcp
fi

# Run SonarQube container
echo "Running SonarQube container..."
docker run -d -p 9000:9000 --name sonarqube sonarqube

echo "SonarQube container is now running."
