#!/bin/sh
cat << EOF
Content-Type: text/plain

restarting emulationstation $(date)
$(sudo /usr/bin/restartemu.sh)
EOF
