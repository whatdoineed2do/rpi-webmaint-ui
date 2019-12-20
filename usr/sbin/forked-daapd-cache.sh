#!/bin/bash

BASEOVERLAY=/var/cache/overlay/forked-daapd
CACHE=/var/cache/forked-daapd

if [ "$1" == "start" ]; then
    mkdir -p ${BASEOVERLAY}
    mount tmpfs -t tmpfs ${BASEOVERLAY} -o size=16M,rw,nosuid,nodev
    mkdir -p ${BASEOVERLAY}/work
    mkdir -p ${BASEOVERLAY}/upper
    chmod 1777 ${BASEOVERLAY}/*

    mount overlay ${CACHE} -t overlay -o lowerdir=${CACHE},upperdir=${BASEOVERLAY}/upper,workdir=${BASEOVERLAY}/work
    exit 0
fi

if [ "$1" == "stop" ]; then
    umount ${CACHE}
    umount ${BASEOVERLAY}

    exit 0
fi

exit 1
