#!/bin/bash

systemctl stop bluetooth; sleep 5
hciconfig hci0 down
killall bluetoothd
hciconfig hci0 up
systemctl start bluetooth
