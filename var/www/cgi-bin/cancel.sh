#!/bin/sh
cat << EOF
Content-Type: text/plain

Cancelling shutdown $(date)
$(sudo /sbin/shutdown -c "web i/f cancel shutdown")
EOF

