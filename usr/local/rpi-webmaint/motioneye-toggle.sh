#!/bin/bash

systemctl is-active --quiet motioneye
STAT=$?

if [ $STAT -eq 0 ]; then
    echo stopping MotionEye
    systemctl stop motioneye
else
    echo starting MotionEye
    systemctl start motioneye
fi
systemctl status motioneye
