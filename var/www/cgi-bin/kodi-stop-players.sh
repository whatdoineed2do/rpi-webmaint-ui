#!/bin/sh
cat << EOF
Content-Type: text/plain

Stopping all playback
$(/usr/local/rpi-webmaint/kodi-stop-players.sh)
EOF
