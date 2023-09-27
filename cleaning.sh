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

# Stop and remove all Docker containers
echo "Stopping and removing all Docker containers..."
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Remove all Docker images
echo "Removing all Docker images..."
docker rmi $(docker images -q)

echo "Patch management and Docker cleanup completed."
