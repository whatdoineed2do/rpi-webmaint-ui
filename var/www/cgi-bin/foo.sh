#!/bin/sh

cat << EOF
Content-type: text/plain


$(uname -a)
$(hostname -I)

$(last | grep    reboot | head -3)
$(last | grep -v reboot | head -5)

$(w)

$(ifconfig eth0)
$(ifconfig wlan0)
EOF
