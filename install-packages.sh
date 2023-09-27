#!/bin/bash

# Check if the server has 2 or more CPUs
cpu_count=$(nproc)

if [[ "$cpu_count" -lt 2 ]]; then
    echo "This script requires at least 2 CPUs to run."
    exit 1
else
    echo "Your server satisfy requirements of at least 2 CPUs to run"
fi

# Patch management
sudo apt update -y
sudo apt upgrade -y

# Clean cache and remove outdated packages
sudo apt autoremove -y
sudo apt autoclean -y

# Check if Git is installed
if ! command -v git > /dev/null 2>&1; then
  echo "Git is not installed. Installing now."
  sudo apt install git -y
else
  echo "Git is already installed"
fi

# Check if Maven is installed
if ! command -v mvn > /dev/null 2>&1; then
  echo "Maven is not installed. Installing now."
  sudo apt install maven -y
else
  echo "Maven is already installed"
fi

# Check if Java JDK 11 is installed
if ! command -v java > /dev/null 2>&1 || ! java -version 2>&1 | grep -q '11\.'; then
  echo "Java JDK 11 is not installed. Installing now."
  sudo apt install openjdk-11-jdk -y
else
  echo "Java JDK 11 is already installed"
fi

# Check if Docker is installed and service is started and enabled
if ! command -v docker > /dev/null 2>&1 || ! systemctl is-active --quiet docker; then
  echo "Docker is not installed or service is not started and enabled. Installing and starting now."
  sudo apt install docker.io -y
  sudo systemctl start docker
  sudo systemctl enable docker
else
  echo "Docker is already installed and service is started and enabled"
fi

# Install remaining packages
if ! command -v ansible > /dev/null 2>&1; then
  echo "Ansible is not installed. Installing now."
  sudo apt install ansible -y
else
  echo "Ansible is already installed"
fi

if ! command -v docker-compose > /dev/null 2>&1; then
  echo "Docker Compose is not installed. Installing now."
  sudo apt install docker-compose -y
else
  echo "Docker Compose is already installed"
fi

if ! command -v terraform > /dev/null 2>&1; then
  echo "Terraform is not installed. Installing now."
  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install terraform
else
  echo "Terraform is already installed"
fi

if ! command -v wget > /dev/null 2>&1; then
  echo "Wget is not installed. Installing now."
  sudo apt install wget -y
else
  echo "Wget is already installed"
fi

if ! command -v curl > /dev/null 2>&1; then
  echo "Curl is not installed. Installing now."
  sudo apt install curl -y
else
  echo "Curl is already installed"
fi
echo "=========================================================================END================================================================================"
