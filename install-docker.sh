#!/usr/bin/env bash

 
# Update the package index and install dependencies
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
 
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
 
# Add Docker APT repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
 
# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce
 
# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker
 
# Add the current user to the 'docker' group to run Docker without sudo
sudo usermod -aG docker $USER
 
# Print Docker version to verify installation
docker --version
 
# Print Docker info to verify the installation and check if Docker is running
docker info
 