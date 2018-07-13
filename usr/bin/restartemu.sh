#!/bin/bash

for i in $(ps -ef | egrep "emulation" | awk '/^pi/ && /tty1/ { print $3}'); do
    kill -- -$i
    sleep 1
    kill -9 $i
done

ps -ef | awk '/^pi/ && /emulationstation/ { print $2 } | xargs kill
ps -ef | awk '/^pi/ && /runcommand.sh/ { print $2 } | xargs kill
killall diaglog
ps -ef | awk '/^pi/ && /bash/ && /tty1/ { print $2 } | xargs kill
