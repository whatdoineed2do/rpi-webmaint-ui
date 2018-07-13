#!/bin/sh
cat << EOF
Content-Type: text/plain

Switching to HDMI audio output
$(/usr/local/bin/kodi-audio-hdmi.sh)
EOF
