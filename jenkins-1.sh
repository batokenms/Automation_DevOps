#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Perform patch management (update and upgrade)
echo "Performing system updates..."
apt update
apt upgrade -y

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing Docker..."
    apt install -y docker.io
fi

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Check the number of CPUs
cpu_count=$(nproc)
if [[ $cpu_count -lt 2 ]]; then
    echo "Error: The system must have at least 2 CPUs to run Jenkins."
    exit 1
fi

# Open ports 8080 and 50000 if they are not open
if ! ufw status | grep -q "8080/tcp"; then
    echo "Opening port 8080..."
    ufw allow 8080/tcp
fi

if ! ufw status | grep -q "50000/tcp"; then
    echo "Opening port 50000..."
    ufw allow 50000/tcp
fi

# Exclude port 22 from UFW rules for SSH
if ! ufw status | grep -q "22/tcp"; then
    echo "Opening port 22 (SSH)..."
    ufw allow 22/tcp
fi

# Enable the firewall
echo "Enabling the firewall..."
ufw enable

# Run Jenkins Server as a container
echo "Running Jenkins container..."
docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --name jenkins \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/usr/bin/docker \
  -v /home/jenkins_home:/var/jenkins_home \
  jenkins/jenkins

echo "Jenkins container is now running."

