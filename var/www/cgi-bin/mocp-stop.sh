#!/bin/sh

cat << EOF
Content-Type: text/plain

Stopping MOC server
$(sudo mocp -s)
EOF
