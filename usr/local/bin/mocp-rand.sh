#!/bin/bash
# mon-fri randomly play 0800-2230
# sat-sun  1300 - 2300
#
# in cron
#
# 00 08 * * 1-5 mocp-rand.sh start
# 00 13 * * 6-7 mocp-rand.sh start
# 35 22 * * *   mocp-rand.sh stop

ARG0=$(basename $0)
LOG=~/mocp-rand.log

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

    mocp-bbcradio.sh start "R$R" 

    _sleep ${RUNTIME} 
    echo "$(date +"%Y-%m-%d %H:%M") finished playing, killing" 
    mocp -x
    killall mocp
}

function _start() {
    ntpd -q -g
    while : ; do
	if [ $(date +%H | sed -e "s/^0*//g") -gt 23 ]; then
	   echo "$(date +"%Y-%m-%d %H:%M") too late, not starting" 
	   return
	fi

	day=$(date +%u)
	now=$(date +%H%M)
	nowhr=$(date +%k)

	case $day in
	    "6"|"7") 
	       echo "$(date +"%Y-%m-%d %H:%M") wkend handling" 
		if [ $nowhr -lt 1300 ]; then
		    WHEN=1300
		else
		    if [ $nowhr -lt 1500 ]; then
			WHEN=1500
		    else
			WHEN=1900
		    fi
	       fi
	    ;;

	    *)  
		if [ $nowhr -lt 1040 ] ; then
		    WHEN=1040
		else
		    WHEN=1630
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

    mocp -x
    killall mocp
    PIDS=$(ps -ef | grep $(basename $0) | awk '{print $2}')
    kill $PIDS
}

function _stop() {
    ZZZ=$((RANDOM%(1200)))
    echo "$(date +"%Y-%m-%d %H:%M") deferring stop $ZZZ" 
    _sleep $ZZZ

    _kill
}


echo "$(date +"%Y-%m-%d %H:%M") - $ARG0: starting" 

case "$1" in
    "start")  _start;;
    "stop")   _stop;;
    "kill")   _kill;;
    "restart")   _stop; start;;
esac

echo "$(date +"%Y-%m-%d %H:%M") - $ARG0: done" 
