#!/bin/bash
#
# Muestra el titulo de la ventana actual
id=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
name=$(xprop -id $id | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
size=$(echo "$name" | wc -m) 
if [ $size -gt 40 ]; then
  name=$(echo "$name" | cut -c 1-35)
  name=$name...
fi
echo "$name"
