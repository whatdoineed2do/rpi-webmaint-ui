#!/bin/bash
# mon-fri randomly play 0800-2230
# sat-sun  1230 - 2300
#
# in cron
#
# 00 08 * * 1-5 mocp-rand.sh start
# 00 13 * * 6-7 mocp-rand.sh start
# 35 22 * * *   mocp-rand.sh stop

ARG0=$(basename $0)
LOG=~/mocp-rand.log

FDSVR=http://localhost:4689
FDSVR=http://localhost:3689

function _zzz(){
    if [ $# -ne 1 ]; then
	return 0
    fi

    tgt_hrs=$(($1/100))
    tgt_mins=$(($1%100))

    now_hrs=$(date +%k)
    now_mins=$(date +%M)

    tgt=$((${tgt_hrs}*3600 + ${tgt_mins}*60))
    now=$((${now_hrs}*3600 + ${now_mins}*60))
    zzz=$(($tgt - $now))

    if [ $zzz -lt 0 ]; then
	echo 0
    else
	echo $zzz
    fi
}

function _sleep(){
    sleep $1
    return
}

function _play(){
    ZZZ=$((RANDOM%(720)))
    echo "$(date +"%Y-%m-%d %H:%M") deferring play $ZZZ"
    _sleep $ZZZ
    R=$((RANDOM%4+1))
    RUNTIME=$((3000 + RANDOM%900 ))
    echo "$(date +"%Y-%m-%d %H:%M") playing R$R for $RUNTIME seconds" 

    #mocp-bbcradio.sh start "R$R" 

    echo "retreiving playable files"
    URIS=$(curl -s "${FDSVR}/api/search?type=tracks&expression=genre+is+%22VIDEO_AUDIO%22" | jq -r '.tracks.items[].uri' | tr '\n' ',' | sed -e "s/,$//")

    echo "cleaning and re-Q"
    curl -s -X PUT  ${FDSVR}/api/queue/clear
    curl -s -X POST ${FDSVR}/api/queue/items/add?uris=${URIS} 
    curl -s -X GET  ${FDSVR}/api/queue | jq -r '.items[].title'

    echo "starting play (${RUNTIME} seconds)"
    curl -s -X PUT  ${FDSVR}/api/player/shuffle?state=true
    curl -s -X PUT  ${FDSVR}/api/player/repeat?state=all

    OUTPUT_HEADPHONE_ID=$(curl -s -X GET  ${FDSVR}/api/outputs | jq '.outputs[] | select(.name | contains("headphones")) | .id' | tr -d '"')
    curl -s -X PUT "${FDSVR}/api/outputs/${OUTPUT_HEADPHONE_ID}" --data "{\"selected\":true, \"volume\": 100}"
    curl -s -X PUT  ${FDSVR}/api/player/play

    _sleep ${RUNTIME} 
    echo "$(date +"%Y-%m-%d %H:%M") finished playing" 
    #mocp -x
    #killall mocp

    curl -s -X PUT ${FDSVR}/api/player/stop

    # is there a bug when stopping ???
    # pcm512x 1-004c: No SCLK, using BCLK: -2
}

function _start() {
    [ -x /usr/sbin/ntpd ] && /usr/sbin/ntpd -q -g
    aplay -Dhw:0,0 /home/pi/sine.wav

    while : ; do
	if [ $(date +%H | sed -e "s/^0*//g") -gt 23 ]; then
	   echo "$(date +"%Y-%m-%d %H:%M") too late, not starting" 
	   return
	fi

	day=$(date +%u)
	now=$(date +%H%M)
	nowhr=$(date +%k)
	WHEN=

	case $day in
	    "6"|"7") 
	       echo "$(date +"%Y-%m-%d %H:%M") wkend handling" 
		if [ $nowhr -lt 1040 ]; then
		    WHEN=1040
		fi
	    ;;

	    *)  
		if [ $nowhr -lt 1010 ] ; then
		    WHEN=1010
		fi
	    ;;
	esac
   
	z=$(_zzz $WHEN)
	if [ $z -gt 0 ]; then
	    echo "not $WHEN, sleeping $(($z/60)) mins"  
	    _sleep $z
	fi

	_play
    done
}

function _kill() {
    echo "$(date +"%Y-%m-%d %H:%M") stopping mocp" 

    #mocp -x
    #killall mocp
    #PIDS=$(ps -ef | grep $(basename $0) | awk '{print $2}')
    #kill $PIDS
    curl -s -X PUT ${FDSVR}/api/player/stop

    THIS_PID=$$
    KILL_PID=$(pgrep $(basename $0) | grep -v $THIS_PID)
    echo "killing $KILL_PID"
    kill $KILL_PID
    echo "$(date +"%Y-%m-%d %H:%M") $$ stopped" 
}

function _stop() {
    ZZZ=$((RANDOM%(1200)))
    echo "$(date +"%Y-%m-%d %H:%M") deferring playback stop $ZZZ" 
    _sleep $ZZZ

    # _kill
    curl -s -X PUT ${FDSVR}/api/player/stop
    echo "$(date +"%Y-%m-%d %H:%M") playback stopped" 
}

function _status() {
    echo "$(date +"%Y-%m-%d %H:%M") play status=$(curl -s -r -X GET ${FDSVR}/api/player | jq -r .state)"
}


#echo "$(date +"%Y-%m-%d %H:%M") - $ARG0: starting" 

case "$1" in
    "start")  _start;;
    "stop")   _stop;;
    "kill")   _kill;;
    "status")   _status;;
    "restart")   _stop; start;;
esac

#echo "$(date +"%Y-%m-%d %H:%M") - $ARG0: done" 
