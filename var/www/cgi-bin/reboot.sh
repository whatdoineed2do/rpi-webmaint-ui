#!/bin/sh
cat << EOF
Content-Type: text/plain

System going down for reboot $(date)
$(sudo /sbin/shutdown -r -t 1 now "web i/f requested reboot")
EOF

