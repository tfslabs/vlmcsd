#!/bin/bash

set -euo pipefail
trap 'echo "Error occurred at line ${LINENO} of ${BASH_SOURCE[0]}. Exiting..."; exit 1' ERR

GIT_FOLDER="/tmp/vlmcsd"
GIT_REPO="https://github.com/tfslabs/vlmcsd.git"
GIT_BRANCH="master"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

if ! command -v gcc &>/dev/null || ! command -v make &>/dev/null; then
    echo "gcc and make are required to compile the service. Please install them."
    exit 1
fi

if ! command -v git &>/dev/null; then
    echo "git is required to clone the repository. Please install git."
    exit 1
fi

if ! command -v systemctl &>/dev/null; then
    echo "systemctl is required to manage system services. Please ensure systemd is installed."
    exit 1
fi

echo -e "\nWelcome to the simple Volume License Management Service installer
(Note): You can always Ctrl+C to cancel the installation
"

rm -rf "$GIT_FOLDER" || true

systemctl stop vlmcsd || true
systemctl disable vlmcsd || true
rm -f /etc/systemd/system/vlmcsd.service
systemctl daemon-reload

echo "Cloning repository branch '$GIT_BRANCH'..."
git clone --depth 5 --branch "$GIT_BRANCH" "$GIT_REPO" "$GIT_FOLDER"

cd "$GIT_FOLDER"
echo "Compiling the service..."
make -j"$(nproc)" vlmcsd

echo "Creating/updating symbolic link for the executable..."
cp "$GIT_FOLDER/bin/vlmcsd" /usr/bin/vlmcsd

echo "Removing Git Repo"
rm -rf "$GIT_FOLDER" || true

echo "Configuring systemd service..."
mkdir -p /etc/systemd/system
cat <<EOF > /etc/systemd/system/vlmcsd.service
[Unit]
Description=Volume License Management Service
Documentation=https://github.com/tfslabs/vlmcsd/wiki
After=network.target
StartLimitBurst=3
StartLimitIntervalSec=60

[Service]
Type=simple
ExecStart=/usr/bin/vlmcsd -P 1688 -H 26100 -C 1033 -l /tmp/vlmcsd.log -T1 -v -D
TimeoutStartSec=0
RestartSec=2
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "Reloading systemd daemon..."
systemctl daemon-reload
echo "Enabling and starting vlmcsd service..."
systemctl enable --now vlmcsd

echo "Installation complete!"
