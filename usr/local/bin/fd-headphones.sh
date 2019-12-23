#!/bin/bash

FDSVR=http://localhost:4689
FDSVR=http://localhost:3689

if [ $# -ne 1 ]; then
    echo "usage: [START | STOP]"
    exit 1
fi

case $1 in
    "START")
        echo "cleaning and start"
	curl -s -X PUT  "${FDSVR}/api/queue/clear"
	curl -s -X POST "${FDSVR}/api/queue/items/add?expression=genre+is+%22VIDEO_AUDIO%22"
	curl -s -X PUT  "${FDSVR}/api/player/play"
    ;;

    "STOP")
	curl -s -X PUT  "${FDSVR}/api/player/stop"
    ;;

    *)
	echo "usage: [START | STOP]"
	exit 2
    ;;
esac
