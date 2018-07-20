#!/bin/sh
cat << EOF
Content-Type: text/plain

restarting bluetoothd $(date)
EOF
sudo /usr/local/rpi-webmaint/restartbt.sh
