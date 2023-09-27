#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Define cleanup parameters (adjust these as needed)
CONTAINER_EXPIRY_DAYS=7  # Number of days before containers are considered for removal
IMAGE_EXPIRY_DAYS=14     # Number of days before images are considered for removal

# Clean up unused containers
echo "Cleaning up unused containers..."
docker container prune --force --filter "until=${CONTAINER_EXPIRY_DAYS}d"

# Clean up unused images
echo "Cleaning up unused images..."
docker image prune --force --all --filter "until=${IMAGE_EXPIRY_DAYS}d"

# Optionally, clean up volumes (use with caution)
# echo "Cleaning up unused volumes..."
# docker volume prune --force

echo "Resource cleanup completed."


# Checks if it's being run as the root user.
# Defines parameters for container and image expiration (you can adjust these values).
# Uses docker container prune to remove containers that are older than CONTAINER_EXPIRY_DAYS days.
# Uses docker image prune to remove images that are older than IMAGE_EXPIRY_DAYS days.

# Resource Optimization: Containers and images that are no longer in use can consume valuable system 
# resources, including disk space and memory. By regularly cleaning up these resources, you 
# can ensure that your server is running efficiently and is not wasting resources.

# Cost Savings: In cloud environments, such as AWS, Azure, or Google Cloud, you are often billed based 
# on the resources you consume. Unused containers and images can lead to unnecessary costs. 
# By cleaning up these resources, you can reduce your cloud infrastructure costs.

# Security: Unused containers can potentially pose security risks if they contain vulnerabilities or outdated
# software. Regular cleanup helps reduce the attack surface by removing unnecessary containers and images.

# Maintenance: Over time, the number of containers and images can grow significantly, making it harder to manage
# and maintain your Docker environment. Automation ensures that cleanup is performed consistently and prevents resource clutter.

# Performance: Unnecessary containers and images can slow down Docker operations. 
# Cleaning up resources can improve the performance of Docker commands and operations.

# Predictability: Automated cleanup allows you to establish a predictable schedule for resource management. 
# You can set retention policies based on your organization's needs and ensure that cleanup happens at regular
# intervals.