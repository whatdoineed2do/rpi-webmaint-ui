#!/bin/sh
cat << EOF
Content-Type: text/plain

System going down $(date)
$(sudo /sbin/shutdown -h -t 1 now "web i/f requested shutdown")
EOF

