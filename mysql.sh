#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Install MySQL Server
echo "Installing MySQL Server..."
apt update
apt install -y mysql-server

# Start MySQL service
echo "Starting MySQL service..."
systemctl start mysql

# Enable MySQL service to start on boot
echo "Enabling MySQL service to start on boot..."
systemctl enable mysql

# Check MySQL service status
mysql_status=$(systemctl is-active mysql)
if [ "$mysql_status" = "active" ]; then
    echo "MySQL is installed, running, and enabled to start on boot."
else
    echo "MySQL installation or startup has encountered an issue."
fi
