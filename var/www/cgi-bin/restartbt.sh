#!/bin/sh
cat << EOF
Content-Type: text/plain

restarting bluetoothd $(date)
EOF
sudo /usr/bin/restartbt.sh
