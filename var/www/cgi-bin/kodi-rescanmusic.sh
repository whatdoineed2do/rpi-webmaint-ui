#!/bin/sh
cat << EOF
Content-Type: text/plain

Rescanning Kodi music library
$(/usr/local/rpi-webmaint/kodi-rescanmusic.sh)
EOF
