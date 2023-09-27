#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Update packages and install security patches
apt-get update
apt-get upgrade -y

# Install Docker
apt-get install -y docker.io

# Start Docker daemon
systemctl start docker

# Enable Docker daemon to start at boot
systemctl enable docker

# Clone the Git repository
git clone https://github.com/joshking1/Docker-Node.js.git

# Change directory to Docker-Node.js
cd Docker-Node.js

# Build the Docker image
docker build -t king-httpd .

# Tag the image
docker tag king-httpd josh1991/king-httpd

# Set Docker Hub credentials as environment variables
# To set these environment variables on your terminal, you can run the following two commands, 
# replacing josh1956 with your Docker Hub username and Josh@12345 with your Docker Hub password:
# export DOCKER_USERNAME=josh1956
# export DOCKER_PASSWORD=Josh@12345

# Login to Docker Hub
echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin

# Push the image to Docker Hub
docker push josh1991/king-httpd
