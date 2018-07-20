#!/bin/sh
cat << EOF
Content-Type: text/plain

Restart forked-daapd $(date)
$(sudo /usr/local/rpi-webmaint/restartforked-daapd.sh)
EOF
