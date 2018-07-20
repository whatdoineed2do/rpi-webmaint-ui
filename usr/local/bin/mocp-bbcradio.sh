#!/bin/bash

STATION=http://www.radiofeeds.co.uk/bbcradio2.pls

case "$1" in
    R1)   STATION=http://www.radiofeeds.co.uk/bbcradio1.pls ;;
    R2)   STATION=http://www.radiofeeds.co.uk/bbcradio2.pls ;;
    R4)   STATION=http://www.radiofeeds.co.uk/bbcradio4fm.pls ;;
    R4X)  STATION=http://www.radiofeeds.co.uk/bbcradio4extra.pls ;;
esac

# force to headphone jack (0=auto, 2=hdmi)
amixer cset numid=3 1

PLAYLIST=/tmp/mocp-$(basename $STATION)
rm -f /tmp/mocp-*
wget ${STATION} -O $PLAYLIST
killall mocp
mocp -S
mocp -c
mocp -a $PLAYLIST
mocp -p
