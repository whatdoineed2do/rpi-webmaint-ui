#!/bin/sh
cat << EOF

$(sudo /usr/local/rpi-webmaint/journalctl.sh mocp-rand | grep mocp)
EOF
