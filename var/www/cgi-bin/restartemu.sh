#!/bin/sh
cat << EOF
Content-Type: text/plain

restarting emulationstation $(date)
$(sudo /usr/local/rpi-webmaint/restartemu.sh)
EOF
