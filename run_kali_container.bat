@echo off
setlocal ENABLEDELAYEDEXPANSION

echo Setting up the Kali Linux container...
echo.

REM Prompt for environment variables
set /p PUID="Enter PUID (default: 1000): "
if "%PUID%"=="" set PUID=1000

set /p PGID="Enter PGID (default: 1000): "
if "%PGID%"=="" set PGID=1000

set /p TITLE="Enter TITLE (default: Kali-Linux-VC): "
if "%TITLE%"=="" set TITLE="Kali-Linux-VC"

REM Prompt for ports
set /p PORT1="Enter first port (default: 3000): "
if "%PORT1%"=="" set PORT1=3000

set /p PORT2="Enter second port (default: 3001): "
if "%PORT2%"=="" set PORT2=3001

REM Prompt for shm-size
set /p SHM_SIZE="Enter shm-size (default: 1gb): "
if "%SHM_SIZE%"=="" set SHM_SIZE="1gb"

REM Prompt for restart option
echo.
echo Select restart option:
echo 1. unless-stopped
echo 2. no
echo 3. always
set /p RESTART_CHOICE="Enter your choice (1, 2, or 3): "
if "%RESTART_CHOICE%"=="2" (
    set RESTART_OPTION=no
) else if "%RESTART_CHOICE%"=="3" (
    set RESTART_OPTION=always
) else (
    set RESTART_OPTION=unless-stopped
)

REM Construct Docker run command
echo.
echo Running the Kali Linux container...
set DOCKER_CMD=docker run -d ^
--name=kali-linux-vc ^
--security-opt seccomp=unconfined ^
-e PUID=!PUID! ^
-e PGID=!PGID! ^
-e TZ=Etc/UTC
-e SUBFOLDER=/

if not "!TITLE!"=="" set DOCKER_CMD=!DOCKER_CMD! ^ -e TITLE=!TITLE!

set DOCKER_CMD=!DOCKER_CMD! ^
-p !PORT1!:3000 ^
-p !PORT2!:3001 ^
--shm-size=!SHM_SIZE! ^
--restart=!RESTART_OPTION! ^
"lscr.io/linuxserver/kali-linux:latest"

call !DOCKER_CMD!

echo.
echo Done! The Kali Linux container has been set up.
pause
