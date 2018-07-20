#!/bin/bash

systemctl stop forked-daapd
sleep 2
systemctl start forked-daapd
