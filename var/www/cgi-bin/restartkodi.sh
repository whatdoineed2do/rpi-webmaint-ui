#!/bin/sh
cat << EOF
Content-Type: text/plain

killing Kodi $(date)
$(sudo /usr/bin/restartkodi.sh)
EOF
