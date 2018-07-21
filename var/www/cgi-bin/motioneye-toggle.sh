#!/bin/sh
cat << EOF
Toggling MotionEye server status
$(sudo /usr/local/rpi-webmaint/motioneye-toggle.sh)
EOF
