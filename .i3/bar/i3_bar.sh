#! /bin/bash

. $(dirname $0)/i3_bar_config

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"

# Window title, "W"
xprop -spy -root _NET_ACTIVE_WINDOW | sed -un 's/.*\(0x.*\)/WIN\1/p' > "${panel_fifo}" &

# Volume, "V"
while :; do
  amixer get Master | grep Left | awk -F'[]%[]' '/%/ {if ($5 == "off") {print "VOL×\n"} else {printf "VOL%d\n", $2}}' > "${panel_fifo}" &
  sleep 3s;
done &

# GMAIL
while :; do
  printf "%s%s\n" "GMA" "$(~/bin/gmail.sh)" > "${panel_fifo}"
  sleep 300s;
done &

#MPC
#while :; do
#  printf "%s%s\n" "MPC" "$(mpc current -f '[[[[%artist%]%title%]]|[%file%]]' | head -c 75)" > "${panel_fifo}"
#  sleep 10s;
#done &

# IRC
# only for init
~/bin/irc_warn &

# Conky
conky -c $(dirname $0)/i3_bar_conky > "${panel_fifo}" &

$(dirname $0)/i3_bar_parser.sh < "${panel_fifo}" \
  | bar -p -f "${font}" -g "${geometry}" -B "${color_back}" -F "${color_fore}" \
  | while read line; do eval "$line"; done &

wait

