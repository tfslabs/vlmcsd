#!/bin/bash
# filepath: f:\theflightsims\windowsserver-mgmttools\vlmcsd-repos\vlmcsd\.systemd\install.sh
set -euo pipefail
trap 'echo "Error occurred at line ${LINENO} of ${BASH_SOURCE[0]}. Exiting..."; exit 1' ERR

GIT_FOLDER="/opt/vlmcsd"
GIT_REPO="https://github.com/tfslabs/vlmcsd.git"
GIT_BRANCH_PRODUCTION="master"
GIT_BRANCH_TESTING="new-guide"
GIT_BRANCH=""

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

echo -e "\nWelcome to the simple Volume Management Service installer
Please select your installation type:
1. Production (Stable)
2. Testing (Unstable)
(Note): You can always Ctrl+C to cancel the installation
"

read -rp "Enter your choice [1-2]: " choice

rm -rf "$GIT_FOLDER" || true

case "$choice" in
    1)
        GIT_BRANCH="$GIT_BRANCH_PRODUCTION"
        ;;
    2)
        GIT_BRANCH="$GIT_BRANCH_TESTING"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo "Cloning repository branch '$GIT_BRANCH'..."
git clone --depth 5 --branch "$GIT_BRANCH" "$GIT_REPO" "$GIT_FOLDER"

cd "$GIT_FOLDER"
echo "Compiling the service..."
make -j"$(nproc)" vlmcsd

echo "Creating/updating symbolic link for the executable..."
ln -sf "$GIT_FOLDER/bin/vlmcsd" /usr/bin/vlmcsd

echo "Configuring systemd service..."
mkdir -p /etc/systemd/system
cat <<EOF > /etc/systemd/system/vlmcsd.service
[Unit]
Description=Volume License Management Service
Documentation=https://github.com/tfslabs/vlmcsd
After=network.target
StartLimitBurst=3
StartLimitIntervalSec=60

[Service]
Type=simple
ExecStart=/usr/bin/vlmcsd -P 1688 -H 26100 -C 1033 -l /var/log/vlmcsd.log -T1 -e -v -D
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