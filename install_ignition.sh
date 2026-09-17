```bash
#!/bin/bash

set -e

DOWNLOAD_PAGE="https://inductiveautomation.com/downloads/ignition"
DOWNLOAD_DIR="$HOME"

echo
echo "Ignition Installer / Upgrade"
echo "============================"
echo
echo "Go to this web page and copy the Linux installer download link:"
echo "$DOWNLOAD_PAGE"
echo

# Read directly from the terminal so this works with:
# curl -fsSL <url> | bash
read -r -p "Download Link: " httplink </dev/tty

# Make sure something was entered
if [ -z "$httplink" ]; then
    echo "ERROR: No download link entered."
    exit 1
fi

# Strip query string, if present, and determine filename
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
```
