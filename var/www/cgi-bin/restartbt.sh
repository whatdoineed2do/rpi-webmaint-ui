#!/bin/sh
cat << EOF
Content-Type: text/plain

restarting bluetoothd $(date)
$(sudo sudo systemctl restart bluetooth)
EOF

