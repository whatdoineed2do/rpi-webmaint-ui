#!/bin/sh

cat << EOF
Content-Type: text/plain

$(sudo /usr/bin/mocp-bbcradio.sh)
$(sudo mocp -i)
EOF
