#!/bin/bash

# Char glyps for powerline fonts
sep_left=""                        # Powerline separator left
sep_right=""                       # Powerline separator right
sep_l_left=""                      # Powerline light separator left
sep_l_right=""                     # Powerline light sepatator right

# Alerts
cpu_alert=75
cpu_core_temp=75
disk_alert=80

# CPU
CPU=`eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4; eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); intervaltotal=$((total-${prevtotal:-0})); echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))"`
echo -n "$CPU% "

#TEMP
if which sensors > /dev/null; then
	TEMP=`sensors | grep Core | awk '{print $3;}' | grep -oEi '[0-9]+.[0-9]+' | awk '{total+=$1; count+=1} END {print total/count}'`
	echo -n "$TEMPºC "
fi

#DISK
DISK_ROOT=`df | grep -w / | awk '{print $5;}'`
if [ -n "$DISK_ROOT" ]; then
	echo -n "/ $DISK_ROOT "
fi
DISK_HOME=`df | grep /home | awk '{print $5;}'`
if [ -n "$DISK_HOME" ]; then
	echo -n "/home $DISK_HOME "
fi
DISK_EXTRA=`df | grep /extra | awk '{print $5;}'`
if [ -n "$DISK_EXTRA" ]; then
	echo -n "/extra $DISK_EXTRA"
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
