#!/bin/sh
[ -r /etc/lsb-release ] && . /etc/lsb-release

if [ -z "$DISTRIB_DESCRIPTION" ] && [ -x /usr/bin/lsb_release ]; then
        # Fall back to using the very slow lsb_release utility
        DISTRIB_DESCRIPTION=$(lsb_release -s -d)
fi

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "\t\t\t$(uname -n)\n"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "\n"

printf "Welcome to %s (%s).\n" "$DISTRIB_DESCRIPTION" "$(uname -r)"
printf "\n"

#System date
date=`date`

#System load
LOAD1=`cat /proc/loadavg | awk {'print $1'}`
LOAD5=`cat /proc/loadavg | awk {'print $2'}`
LOAD15=`cat /proc/loadavg | awk {'print $3'}`

#System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))

#Root fs info
root_usage=`df -h / | awk '/\// {print $4}'|grep -v "^$"`
fsperm=$(cat /proc/mounts | grep -i rootfs | awk '{print $4}' | awk -F"," '{print $1}')

#Memory Usage
memory_usage=`free -m | awk '/Mem:/ { total=$2 } /buffers\/cache/ { used=$3 } END { printf("%3.1f%%", used/total*100)}'`
if    [ "$(swapon --show --noheadings | wc -l)" -gt 0 ];then
  swap_usage=`free -m | awk '/Swap/ { printf("%3.1f%%", $3/$2*100) }'`
else
  swap_usage="NoSwap"
fi

#Users
users=`users | wc -w`
USER=`whoami`

#Processes
processes=`ps aux | wc -l`

echo "System information as of: $date"
echo
printf "System Load:\t%s %s %s\tSystem Uptime:\t\t%s "days" %s "hours" %s "min" %s "sec"\n" $LOAD1, $LOAD5, $LOAD15 $upDays $upHours $upMins $upSecs
printf "Memory Usage:\t%s\t\t\tSwap Usage:\t\t%s\n" $memory_usage $swap_usage
printf "Usage On /:\t%s\t\t\tAccess Rights on /:\t%s\n" $root_usage $fsperm
printf "Local Users:\t%s\t\t\tWhoami:\t\t\t%s\n" $users $USER
printf "Processes:\t%s\t\t\t\n" $processes
