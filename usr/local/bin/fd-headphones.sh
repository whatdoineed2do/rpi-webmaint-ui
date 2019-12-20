#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: [START | STOP]"
    exit 1
fi

case $1 in
    "START")
	echo "force headphone output"
	sudo amixer cset numid=3 1
        echo "cleaning and start"
	curl -s -X PUT  "http://localhost:4689/api/queue/clear"
	curl -s -X POST "http://localhost:4689/api/queue/items/add?expression=genre+is+%22VIDEO_AUDIO%22"
	curl -s -X PUT  "http://localhost:4689/api/player/play"
    ;;

    "STOP")
	curl -s -X PUT  "http://localhost:4689/api/player/stop"
    ;;

    *)
	echo "usage: [START | STOP]"
	exit 2
    ;;
esac
