#!/bin/sh
cat << EOF
Content-Type: text/plain

killing Kodi $(date)
$(sudo /usr/local/rpi-webmaint/restartkodi.sh)
EOF
