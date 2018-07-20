#!/bin/sh

cat << EOF
Content-Type: text/plain

$(sudo /usr/local/rpi-webmaint/mocp-bbcradio.sh)
$(sudo mocp -i)
EOF
