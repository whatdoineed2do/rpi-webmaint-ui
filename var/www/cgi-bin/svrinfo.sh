#!/bin/sh
cat << EOF
Content-Type: text/plain

$(date)
$(hostname -I) $(uname -s -n -r -m)

$(last | grep    reboot | head -3)
$(last | grep -v reboot | head -5)

$(w)

$(cat /proc/net/bonding/bond0 | grep -v queue | grep -v Duplex)

$(/sbin/ifconfig eth0)

$(/sbin/ifconfig wlan0)

$(netstat -a -t -n | grep -v LISTEN)

$(df -h | grep -v tmpfs)
$(free)

$(ps -e --sort=-pcpu -o pid,user,vsz,rss,pcpu,pmem,cputime,fname | awk '{ if ($1 > 100) print }' | grep -v kworker | grep -v VCH | grep -v kthread | grep -v ksoft | grep -v rcu_she | head -10)
EOF
