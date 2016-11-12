#!/bin/bash

case "$OSTYPE" in
    linux-gnu)
        CPU=`eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4; eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); intervaltotal=$((total-${prevtotal:-0})); echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))"`
		echo $CPU

        FREE_MEM=`free | awk '/buffers\/cache/{print (100 - ($4/($3+$4) * 100.0));}'`
		echo $FREE_MEM

        printf "CPU:%.f%% Mem:%.f%%" $CPU $FREE_MEM
        ;;
esac

case "$OSTYPE" in
    linux-gnu)
        io_line_count=`iostat -d -x -m | wc -l` ;
        iostat -d -x -m 1 2 -z | tail -n +$io_line_count | grep -e "^sd[a-z].*" | awk 'BEGIN{rsum=0; wsum=0}{ rsum+=$6; wsum+=$7} END {print "IO:" rsum " " wsum ""}'
        ;;
esac

case "$OSTYPE" in
    linux-gnu)
        if [ -z "$1" ]; then
            echo
            echo usage: $0 network-interface
            echo
            echo e.g. $0 eth0
            echo
            exit
        fi

        IF=$1

        R1=`cat /sys/class/net/$1/statistics/rx_bytes`
        T1=`cat /sys/class/net/$1/statistics/tx_bytes`
        sleep 1
        R2=`cat /sys/class/net/$1/statistics/rx_bytes`
        T2=`cat /sys/class/net/$1/statistics/tx_bytes`
        TBPS=`expr $T2 - $T1`
        RBPS=`expr $R2 - $R1`
        TKBPS=`expr $TBPS / 1024`
        RKBPS=`expr $RBPS / 1024`
        printf "%s:%d %d " $1 $RKBPS $TKBPS
        ;;
esac

case "$OSTYPE" in
    linux-gnu)
            if which sensors > /dev/null; then
                sensors | grep Core | awk '{print $3;}' | grep -oEi '[0-9]+.[0-9]+' | awk '{total+=$1; count+=1} END {print total/count,"C"}'
            fi
        ;;
esac
