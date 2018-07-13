#!/bin/sh
cat << EOF
Content-Type: text/plain

Rescanning Kodi music library
$(/usr/local/bin/kodi-rescanmusic.sh)
EOF
