#!/bin/bash

# Upgrade the system and install go
sudo apt update
sudo apt upgrade -y
sudo apt install gcc git make -y
sudo snap install --classic go
sudo mkdir -p /opt/go/bin

# Export environment variables
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Create a system user for running the service
sudo useradd -m -d /opt/loom --system --shell /usr/sbin/nologin loom
sudo -u loom mkdir -p /opt/loom/config

# Get Loom SDK and build binaries


# Install SDK


# Copy the binaries to /opt/go/bin/
sudo cp $HOME/go/bin/loom* /opt/go/bin/

# Create systemd unit file
echo "[Unit]
Description=Loom instance
After=network-online.target
[Service]
User=loom
ExecStart=/opt/go/bin/loom start --home=/opt/loom/
Restart=always
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target" > loom.service

sudo mv loom.service /etc/systemd/system/
sudo systemctl enable loom.service

# Create the config skeleton as user loom
sudo -u loom /opt/go/bin/loom unsafe-reset-all --home=/opt/loom


echo "Get genesis.json"
echo "Run 'sudo service loom start' to start the service."
echo "Run 'Output log by running `journalctl -u loom -f`"
