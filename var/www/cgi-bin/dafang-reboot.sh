#!/bin/bash

ARG=$(basename $0)
HOST=
[ "$ARG" == "dafang-reboot1.sh" ] && HOST=192.168.0.207
[ "$ARG" == "dafang-reboot2.sh" ] && HOST=192.168.0.208
[ "$ARG" == "dafang-reboot3.sh" ] && HOST=192.168.0.209

if [ -z $HOST ]; then
    echo "no known host"
else
    ping -c 3 ${HOST}
    curl -u : "http://${HOST}/cgi-bin/action.cgi?cmd=reboot"
fi
