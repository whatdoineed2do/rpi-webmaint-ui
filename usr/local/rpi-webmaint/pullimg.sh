#!/bin/bash

. /etc/rpi-webmaint.conf

case "$@" in
    d1) curl -u ${PULLIMG_D_USER}:${PULLIMG_D_PASSWD} http://192.168.0.207/cgi-bin/currentpic.cgi -o - | base64
	;;
    d2) curl -u ${PULLIMG_D_USER}:${PULLIMG_D_PASSWD} http://192.168.0.208/cgi-bin/currentpic.cgi -o - | base64
	;;
    d3) curl -u ${PULLIMG_D_USER}:${PULLIMG_D_PASSWD} http://192.168.0.209/cgi-bin/currentpic.cgi -o - | base64
	;;
    f) curl "http://192.168.0.197/snapshot.cgi?user=${PULLIMG_F_USER}&pwd=${PULLIMG_F_PASSWD}&15322046125780.09861329200450186" | base64
	;;

    m) curl "http://192.168.0.156:8765/picture/1/current/?_=${PULLIMG_O_A}&_username=${PULLIMG_O_B}&_signature=${PULLIMG_O_C}" -o - | base64
	;;
    o) curl http://192.168.0.156/cgi-bin/snap.sh -o - | base64
	;;

    *) ;;
esac
