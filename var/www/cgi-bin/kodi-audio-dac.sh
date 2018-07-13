#!/bin/sh
cat << EOF
Content-Type: text/plain

Switching to DAC audio output
$(/usr/local/bin/kodi-audio-dac.sh)
EOF
