#!/bin/bash

case "$OSTYPE" in
    linux-gnu)
        CPU=`eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4; eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); intervaltotal=$((total-${prevtotal:-0})); echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))"`
		echo -n "$CPU% "

        #FREE_MEM=`free | awk '/buffers\/cache/{print (100 - ($4/($3+$4) * 100.0));}'`
		#echo $FREE_MEM

        #printf "CPU:%.f%% Mem:%.f%%" $CPU $FREE_MEM
        ;;
esac

case "$OSTYPE" in
    linux-gnu)
            if which sensors > /dev/null; then
                sensors | grep Core | awk '{print $3;}' | grep -oEi '[0-9]+.[0-9]+' | awk '{total+=$1; count+=1} END {print total/count,"ºC"}'
            fi
        ;;
esac
