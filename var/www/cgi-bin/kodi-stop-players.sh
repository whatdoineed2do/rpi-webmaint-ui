#!/bin/sh
cat << EOF
Content-Type: text/plain

Stopping all playback
$(/usr/local/bin/kodi-stop-players.sh)
EOF
