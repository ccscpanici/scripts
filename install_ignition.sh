```bash
#!/bin/bash

set -e

DOWNLOAD_PAGE="https://inductiveautomation.com/downloads/ignition"
DOWNLOAD_DIR="$HOME"

# Display interactive instructions directly on the terminal.
cat >/dev/tty <<EOF

Ignition Installer / Upgrade
============================

Go to this web page and copy the Linux installer download link:

$DOWNLOAD_PAGE

EOF

# Read the download URL directly from the terminal.
printf "Download Link: " >/dev/tty
read -r httplink </dev/tty

if [ -z "$httplink" ]; then
    echo "ERROR: No download link entered." >/dev/tty
    exit 1
fi

# Remove a query string, if present, and determine the filename.
filename=$(basename "${httplink%%\?*}")

if [ -z "$filename" ]; then
    echo "ERROR: Could not determine installer filename." >/dev/tty
    exit 1
fi

installer_path="$DOWNLOAD_DIR/$filename"

cat >/dev/tty <<EOF

Installer: $filename
Download location: $installer_path

Downloading from:
$httplink

EOF

wget \
    --referer="$DOWNLOAD_PAGE" \
    -O "$installer_path" \
    "$httplink"

echo >/dev/tty
echo "Making installer executable..." >/dev/tty
chmod +x "$installer_path"

echo >/dev/tty
echo "Running Ignition installer..." >/dev/tty
echo >/dev/tty

sudo "$installer_path"
```
