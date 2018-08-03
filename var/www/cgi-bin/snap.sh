#!/bin/bash

exec sudo raspistill -w 1296 -h 972 -mm average -rot 90 -awb auto -ex auto -ev 5 -a 12 -q 70 --exif none --thumb none -o -
