# HackLab

This repository contains configuration files and scripts to set up a Dockerized environment for testing and learning about vulnerabilities using Kali Linux and other related tools. Below is the detailed explanation and usage guide for each component of this repository.

<br>

## Table of Contents
- [Compose File](#compose-file)
- [Batch Script (Windows)](#batch-script-windows)
- [Bash Script (Linux/Mac)](#bash-script-linuxmac)
- [Usage Instructions](#usage-instructions)
- [Components Overview](#components-overview)
- [Network Configuration](#network-configuration)

<br>

## Compose File
The `docker-compose.yml` file defines the services to set up a hacking lab environment. It includes:

### Services:
1. **kali-linux-c**:
   - Based on the `kalilinux/kali-rolling` image.
   - Fixed IP: `172.20.0.5`.
   - Configured to restart automatically unless stopped manually.

2. **kali-linux-vc**:
   - Based on `lscr.io/linuxserver/kali-linux`.
   - Supports custom environment variables for user and group IDs (`PUID` and `PGID`), timezone, and title.
   - Fixed IP: `172.20.0.10`.
   - Optional GPU connection for Linux hosts.
   - Ports: `3000` and `3001`.

3. **vulnerable**:
   - Deploys the `vulnerables/web-dvwa` image.
   - Connected to the same network (`hacking-lab`).

### Network:
- **hacking-lab**:
  - Bridge network with a custom subnet (`172.20.0.0/24`).
  - Internal network disabled by default for internet connectivity but can be enabled.

<br>

## Batch Script (Windows)
The `setup.bat` script simplifies container creation for Windows users.

### Features:
- Prompts for:
  - `PUID` and `PGID`
  - Custom title
  - Ports
  - Shared memory size (`shm-size`)
  - Restart policy
- Automatically runs the Docker container with the provided inputs.

### Usage:
1. Run the script by double-clicking or from the terminal.
2. Follow the prompts to configure the container.
3. The container will be created and started with the specified settings.

<br>

## Bash Script (Linux/Mac)
The `setup.sh` script simplifies container creation for Linux/Mac users.

### Features:
- Interactive prompts for:
  - `PUID` and `PGID`
  - Custom title
  - Ports
  - Shared memory size (`shm-size`)
  - Restart policy
- Automatically constructs and runs the Docker container.

### Usage:
1. Make the script executable: `chmod +x setup.sh`
2. Run the script: `./setup.sh`
3. Follow the prompts to configure the container.
4. The container will be created and started with the specified settings.

<br>

## Usage Instructions
1. Clone this repository:
   ```bash
   git clone https://github.com/RashmithaDeSilva/HackLab.git
   cd HackLab
   ```

   * Before using set your PC ID in Compose File (you can get it using the 'id' command in the terminal) then replace it with compose file "PUID" and "PGID" Also if you need more access to work comment "security_opt" in compose file also if you are using windows comment "device" in Compose File. 
   
2. **Using Docker Compose:**
   - Start all services:
     ```bash
     docker-compose up -d
     ```
   - Stop all services:
     ```bash
     docker-compose down
     ```

3. **Using Scripts:**
   - On Windows, run `setup.bat`.
   - On Linux/Mac, run `setup.sh`.

4. Access the services via their respective ports (e.g., `http://localhost:3000` for `kali-linux-vc`).

<br>

## Components Overview
### Services
#### kali-linux-c
- A lightweight Kali Linux container for terminal-based tasks.

#### kali-linux-vc
- A more feature-rich Kali Linux container with optional GPU support and web-based tools.

#### vulnerable
- Deploys Damn Vulnerable Web Application (DVWA) for practicing vulnerability testing.

### Network
- All services are connected to the `hacking-lab` network, ensuring isolation and fixed IPs for easy management.

<br>

## Network Configuration
The `hacking-lab` network uses a bridge driver with the following configuration:
- Subnet: `172.20.0.0/24`
- Fixed IPs assigned to key containers.

To enable internet connectivity for the network, remove the `internal: true` line in the `docker-compose.yml` file.

<br>

## Notes
- Ensure Docker and Docker Compose are installed on your system.
- Update environment variables as needed in the scripts or compose file.
- This setup is designed for educational purposes and should not be used in production environments without proper security measures.

<br>

Happy hacking!

