#!/bin/bash
# install_docker.sh — Automated Docker + NVIDIA runtime setup by AG Tech Sec

set -e

echo "🔹 Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

echo "🔹 Installing Docker and dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "🔹 Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "🔹 Installing NVIDIA Container Toolkit (for GPU acceleration)..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update -y
sudo apt install -y nvidia-container-toolkit
sudo systemctl restart docker

echo "✅ Docker and NVIDIA runtime installed successfully!"

