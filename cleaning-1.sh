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

# List running Docker containers
echo "Listing running Docker containers:"
docker ps

# Prompt user to stop and remove containers
read -p "Enter the names of containers to stop and remove (comma-separated, or 'all' for all containers): " containers

if [ "$containers" == "all" ]; then
    echo "Stopping and removing all Docker containers..."
    docker stop $(docker ps -q)
    docker rm $(docker ps -aq)
else
    # Split comma-separated input into an array
    IFS=',' read -ra container_names <<< "$containers"
    
    for container_name in "${container_names[@]}"; do
        # Stop and remove the specified container
        echo "Stopping and removing container: $container_name"
        docker stop "$container_name"
        docker rm "$container_name"
    done
fi

# Remove all Docker images
echo "Removing all Docker images..."
docker rmi $(docker images -q)

echo "Patch management and Docker cleanup completed."
