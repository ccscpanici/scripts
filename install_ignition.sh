#!/bin/bash

# download the latest version of ignition
echo -e "Go to this web page, and paste in the download link. \nhttps://inductiveautomation.com/downloads/ignition\n"
echo -e "Download Link: "
read httplink
nlines=$(wc -l < $httplink)

filename=`echo "$httplink" | rev | cut -d'/' -f1 | rev`
echo -e "filename: $filename \n"

echo -e "Downloading from: $httplink \n"

####### Enable when ready
wget --referer=https://inductiveautomation.com/downloads/ignition $httplink

echo -e "Making file executable.\n"
sudo chmod +x $filename

echo -e "Running Installer.\n"
./$filename

