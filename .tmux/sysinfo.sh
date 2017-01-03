#!/bin/bash
# Tmux sysinfo

# Char glyps for powerline fonts
sep_left=""                        # Powerline separator left
sep_right=""                       # Powerline separator right
sep_l_left=""                      # Powerline light separator left
sep_l_right=""                     # Powerline light sepatator right

# Alerts
cpu_alert=75
cpu_core_temp=70
disk_alert=80

# CPU
cpu=`eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4; eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); intervaltotal=$((total-${prevtotal:-0})); echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))"`

if [ ${cpu} -gt ${cpu_alert} ]; then
	cpu_fg=brightwhite; cpu_bg=red;
else
	cpu_fg=brightwhite; cpu_bg=brightblack;
fi
cpu="#[fg=${cpu_bg},bg=black]${sep_left}#[fg=${cpu_fg},bg=${cpu_bg}] CPU: ${cpu}% #[fg=black,bg=${cpu_bg}]${sep_left}"
echo -n "${cpu}"

#TEMP
if which sensors > /dev/null; then
	temp=`sensors | grep Core | awk '{print $3;}' | grep -oEi '[0-9]+.[0-9]+' | awk '{total+=$1; count+=1} END {print total/count}'`
	if [ ${temp} -gt ${cpu_core_temp} ]; then
		temp_fg=brightwhite; temp_bg=red;
	else
		temp_fg=brightwhite; temp_bg=brightblack;
	fi
	temp="#[fg=${temp_bg},bg=black]${sep_left}#[fg=${temp_fg},bg=${temp_bg}] ${temp}ºC #[fg=black,bg=${temp_bg}]${sep_left}"
	echo -n "${temp}"
fi

#DISK
disk_root=`df | grep -w / | awk '{print $5;}' | grep -oEi '[0-9]+'`
if [ -n "$disk_root" ]; then
	if [ ${disk_root} -gt ${disk_alert} ]; then
		disk_fg=black; disk_bg=yellow;
	else
		disk_fg=brightwhite; disk_bg=brightblack;
	fi
	disk_root="#[fg=${disk_bg},bg=black]${sep_left}#[fg=${disk_fg},bg=${disk_bg}] / ${disk_root}% #[fg=black,bg=${disk_bg}]${sep_left}"
	echo -n "${disk_root}"
fi

disk_home=`df | grep -w /home | awk '{print $5;}' | grep -oEi '[0-9]+'`
if [ -n "$disk_home" ]; then
	if [ ${disk_home} -gt ${disk_alert} ]; then
		disk_fg=black; disk_bg=yellow;
	else
		disk_fg=brightwhite; disk_bg=brightblack;
	fi
	disk_home="#[fg=${disk_bg},bg=black]${sep_left}#[fg=${disk_fg},bg=${disk_bg}] /home ${disk_home}% #[fg=black,bg=${disk_bg}]${sep_left}"
	echo -n "${disk_home}"
fi
disk_extra=`df | grep -w extra | awk '{print $5;}' | grep -oEi '[0-9]+'`
if [ -n "$disk_extra" ]; then
	if [ ${disk_extra} -gt ${disk_alert} ]; then
		disk_fg=black; disk_bg=yellow;
	else
		disk_fg=brightwhite; disk_bg=brightblack;
	fi
	disk_extra="#[fg=${disk_bg},bg=black]${sep_left}#[fg=${disk_fg},bg=${disk_bg}] /extra ${disk_extra}% #[fg=black,bg=${disk_bg}]${sep_left}"
	echo -n "${disk_extra}"
fi



#NETSPEED
#case "$OSTYPE" in
#    linux-gnu)
#        IF=eth0
#        R1=`cat /sys/class/net/$1/statistics/rx_bytes`
#        T1=`cat /sys/class/net/$1/statistics/tx_bytes`
#        sleep 1
#        R2=`cat /sys/class/net/$1/statistics/rx_bytes`
#        T2=`cat /sys/class/net/$1/statistics/tx_bytes`
#        TBPS=`expr $T2 - $T1`
#        RBPS=`expr $R2 - $R1`
#        TKBPS=`expr $TBPS / 1024`
#        RKBPS=`expr $RBPS / 1024`
#        printf "%s:%d %d " $IF $RKBPS $TKBPS
#        ;;
#esac
