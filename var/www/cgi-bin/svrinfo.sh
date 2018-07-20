#!/bin/bash
cat << EOF
Content-Type: text/plain

$(date)  $([ -f "/sys/class/thermal/thermal_zone0/temp" ] && temp=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && echo "${temp}oC")
$(hostname -I) $(uname -s -n -r -m)

$(last | grep    reboot | head -3)
$(last | grep -v reboot | head -5)

$(w)

$(cat /proc/net/bonding/bond0 | grep -v queue | grep -v Duplex)

$(/sbin/ifconfig eth0)

$(/sbin/ifconfig wlan0)

$(netstat -a -t -n | grep -v LISTEN)

$(df -h | grep -v /run | grep -v /sys)
$(free -h)

$(uptime)
$(ps -e --sort=-pcpu -o pid,user,vsz,rss,pcpu,pmem,cputime,fname | awk '{ if ($1 > 100) print }' | grep -v kworker | grep -v VCH | grep -v kthread | grep -v ksoft | grep -v rcu_she | head -10)

$([ -f /var/log/mocp-rand.log ] && (sudo mocp -i ; systemctl status mocp-rand ; tail -30 /var/log/mocp-rand.log) )
EOF
