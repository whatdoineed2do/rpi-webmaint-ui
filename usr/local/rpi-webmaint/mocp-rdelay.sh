#!/bin/bash

ARG0=$(basename $0)
DELAY=$(($RANDOM%60*15))
echo "$ARG0: delaying $DELAY seconds"
sleep $DELAY

case "$1" in
    start) mocp-bbcradio.sh  R2 ;;
    stop)  mocp -x; killall mocp ;;
esac
