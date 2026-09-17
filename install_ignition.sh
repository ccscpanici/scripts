#!/bin/bash

set -e

DOWNLOAD_PAGE="https://inductiveautomation.com/downloads/ignition"
DOWNLOAD_DIR="$HOME"

echo
echo "Ignition Installer / Upgrade"
echo "============================"
echo
echo "Go to this web page and copy the Linux installer download link:"
echo
echo "$DOWNLOAD_PAGE"
echo

# Read from the terminal instead of stdin because the script
# may be executed using: curl ... | bash
printf "Download Link: " >/dev/tty
read -r httplink </dev/tty

if [ -z "$httplink" ]; then
    echo "ERROR: No download link entered."
    exit 1
fi

# Remove query parameters from URL when determining filename
filename=$(basename "${httplink%%\?*}")

if [ -z "$filename" ]; then
    echo "ERROR: Could not determine installer filename."
    exit 1
fi

installer_path="$DOWNLOAD_DIR/$filename"

echo
echo "Installer: $filename"
echo "Download location: $installer_path"
echo
echo "Downloading from:"
echo "$httplink"
echo

wget \
    --referer="$DOWNLOAD_PAGE" \
    -O "$installer_path" \
    "$httplink"

echo
echo "Making installer executable..."
chmod +x "$installer_path"

echo
echo "Running Ignition installer..."
echo

sudo "$installer_path"
