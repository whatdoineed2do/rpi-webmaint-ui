#!/bin/bash

#killall kodi_v7.bin
#sleep 2
#restartemu.sh

sudo killall -9 kodi_v7.bin kodi kodi-standalone
sleep 1
sudo systemctl kill kodi
sudo systemctl stop kodi
sleep 3
sudo systemctl restart kodi

