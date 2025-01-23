#!/bin/bash

echo "Setting up the Kali Linux container..."
echo

# Prompt for environment variables with default values
read -p "Enter PUID (default: 1000): " PUID
PUID=${PUID:-1000}

read -p "Enter PGID (default: 1000): " PGID
PGID=${PGID:-1000}

read -p "Enter TITLE (default: Kali-Linux-VC): " TITLE
TITLE=${TITLE:-Kali-Linux-VC}

# Prompt for ports
read -p "Enter first port (default: 3000): " PORT1
PORT1=${PORT1:-3000}

read -p "Enter second port (default: 3001): " PORT2
PORT2=${PORT2:-3001}

# Prompt for shm-size
read -p "Enter shm-size (default: 1gb): " SHM_SIZE
SHM_SIZE=${SHM_SIZE:-1gb}

# Prompt for restart option
echo
echo "Select restart option:"
echo "1. unless-stopped"
echo "2. no"
echo "3. always"
read -p "Enter your choice (1, 2, or 3): " RESTART_CHOICE

case $RESTART_CHOICE in
  2)
    RESTART_OPTION="no"
    ;;
  3)
    RESTART_OPTION="always"
    ;;
  *)
    RESTART_OPTION="unless-stopped"
    ;;
esac

# Construct Docker run command
echo
echo "Running the Kali Linux container..."
docker run -d \
  --name=kali-linux-vc \
  --security-opt seccomp=unconfined \ # optional
  -e PUID=${PUID} \
  -e PGID=${PGID} \
  -e TZ=Etc/UTC \
  -e SUBFOLDER=/ \
  -e TITLE=${TITLE} \
  -p ${PORT1}:3000 \
  -p ${PORT2}:3001 \
  --device /dev/dri:/dev/dri \ # optional
  --shm-size=${SHM_SIZE} \ # optional
  --restart=${RESTART_OPTION} \
  lscr.io/linuxserver/kali-linux:latest

echo
echo "Done! The Kali Linux container has been set up."
