#!/bin/bash
cat << EOF
$(/usr/local/rpi-webmaint/pullimg.sh $QUERY_STRING)
EOF
