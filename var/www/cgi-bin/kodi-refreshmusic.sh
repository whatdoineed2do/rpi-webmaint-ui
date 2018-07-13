#!/bin/sh
cat << EOF
Content-Type: text/plain

Refreshing Kodi music library
$(kodi-refreshmusic.sh)
EOF
