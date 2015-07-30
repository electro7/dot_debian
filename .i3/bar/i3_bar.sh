#! /bin/bash
#
# I3 bar with https://github.com/LemonBoy/bar

. $(dirname $0)/i3_bar_config

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"

# Window title, "WIN"
xprop -spy -root _NET_ACTIVE_WINDOW | sed -un 's/.*\(0x.*\)/WIN\1/p' > "${panel_fifo}" &

# i3 Workspaces, "WSP"
# TODO : Restarting I3 breaks the IPC socket con. :(
#$(dirname $0)/i3_workspaces.py > "${panel_fifo}" &
$(dirname $0)/i3_workspaces.pl > "${panel_fifo}" &

# Volume, "VOL"
while :; do
  amixer get Master | grep "${snd_cha}" | awk -F'[]%[]' '/%/ {if ($7 == "off") {print "VOL×\n"} else {printf "VOL%d%%%%\n", $2}}' > "${panel_fifo}" &
  sleep 3s;
done &

# GMAIL, "GMA"
while :; do
  printf "%s%s\n" "GMA" "$(~/bin/gmail.sh)" > "${panel_fifo}"
  sleep 300s;
done &

#MPD
#while :; do
#  printf "%s%s\n" "MPD" "$(ncmpcpp --now-playing '{{"%a"} {"%f"}}' | head -c 60)" > "${panel_fifo}"
#  sleep 10s;
#done &

# IRC, "IRC"
# only for init
~/bin/irc_warn &

# Conky, "SYS"
conky -c $(dirname $0)/i3_bar_conky > "${panel_fifo}" &

# Loop fifo
$(dirname $0)/i3_bar_parser.sh < "${panel_fifo}" \
  | lemonbar -p -f "${font}" -f "${iconfont}" -g "${geometry}" -B "${color_back}" -F "${color_fore}" \
  | while read line; do eval "$line"; done &

wait

