#!/bin/bash

# Welcome message
echo "Hi User, Thanks for Using This Script!"
echo "(Automated Script By discord @Notlol95)"
echo ""

# Prompt for key
read -p "Please enter a valid key: " key

if [ "$key" != "crashcloud95" ]; then
    echo "Invalid key! Exiting..."
    exit 1
fi

echo "Key verified successfully!"
echo ""

# Get user input for configurations
read -p "Enter USERNAME: " username
read -p "Enter PASSWORD: " password
read -p "Enter RAM SIZE (e.g., 4G): " ram_size
read -p "Enter CPU CORES (e.g., 4): " cpu_cores
read -p "Enter DISK SIZE (e.g., 400G): " disk_size
read -p "Enter DISK2 SIZE (e.g., 100G): " disk2_size

# Confirm input
echo ""
echo "Is this information correct?"
echo "----------------------------"
echo "USERNAME: $username"
echo "PASSWORD: $password"
echo "RAM SIZE: $ram_size"
echo "CPU CORES: $cpu_cores"
echo "DISK SIZE: $disk_size"
echo "DISK2 SIZE: $disk2_size"
echo "----------------------------"
read -p "Type (y/n) to confirm: " confirm

if [ "$confirm" != "y" ]; then
    echo "Installation aborted!"
    exit 1
fi

# Update the win10.yml file
cat <<EOF > win10.yml
version: '3'
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "10"
      USERNAME: "$username"
      PASSWORD: "$password"
      RAM_SIZE: "$ram_size"
      CPU_CORES: "$cpu_cores"
      DISK_SIZE: "$disk_size"
      DISK2_SIZE: "$disk2_size"
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - "8006:8006"
      - "3389:3389/tcp"
      - "3389:3389/udp"
    stop_grace_period: 2m
EOF

echo ""
echo "Configuration updated successfully!"
echo "Starting the Docker container..."

# Start the container
docker-compose -f win10.yml up -d

echo "Installation complete!"
