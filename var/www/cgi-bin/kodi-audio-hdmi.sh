#!/bin/sh
cat << EOF
Content-Type: text/plain

Switching to HDMI audio output
$(/usr/local/rpi-webmaint/kodi-audio-hdmi.sh)
EOF
