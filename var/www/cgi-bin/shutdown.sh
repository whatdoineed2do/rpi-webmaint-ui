#!/bin/sh

REQ_ORIGIN=$(echo $REMOTE_ADDR | cut -f 1,2 -d '.')

if [ "$REQ_ORIGIN" = "192.168" ]; then
cat << EOF
Content-Type: text/plain

System going down $(date)
$(sudo /sbin/shutdown -h -t 1 now "web i/f requested shutdown")
EOF
else
cat << EOF
Content-Type: text/plain

System stable
EOF
fi
