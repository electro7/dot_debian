#! /bin/bash
#
# I3 bar with https://github.com/LemonBoy/bar

. $(dirname $0)/i3_lemonbar_config

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"

### EVENTS METERS

# Window title, "WIN"
xprop -spy -root _NET_ACTIVE_WINDOW | sed -un 's/.*\(0x.*\)/WIN\1/p' > "${panel_fifo}" &

# i3 Workspaces, "WSP"
# TODO : Restarting I3 breaks the IPC socket con. :(
$(dirname $0)/i3_workspaces.pl > "${panel_fifo}" &

# IRC, "IRC"
# only for init
~/bin/irc_warn &

# Conky, "SYS"
conky -c $(dirname $0)/i3_lemonbar_conky > "${panel_fifo}" &

### UPDATE INTERVAL METERS
cnt_vol=${upd_vol}
cnt_mail=${upd_mail}
cnt_mpd=${upd_mpd}

while :; do

  # Volume, "VOL"
  if [ $((cnt_vol++)) -ge ${upd_vol} ]; then
    amixer get Master | grep "${snd_cha}" | awk -F'[]%[]' '/%/ {if ($7 == "off") {print "VOL×\n"} else {printf "VOL%d%%%%\n", $2}}' > "${panel_fifo}" &
    cnt_vol=0
  fi

  # GMAIL, "GMA"
  if [ $((cnt_mail++)) -ge ${upd_mail} ]; then
    printf "%s%s\n" "GMA" "$(~/bin/gmail.sh)" > "${panel_fifo}"
    cnt_mail=0
  fi

  # MPD
  if [ $((cnt_mpd++)) -ge ${upd_mpd} ]; then
    #printf "%s%s\n" "MPD" "$(ncmpcpp --now-playing '{%a - %t}|{%f}' | head -c 60)" > "${panel_fifo}"
    printf "%s%s\n" "MPD" "$(mpc current -f '[[%artist% - ]%title%]|[%file%]' 2>&1 | head -c 70)" > "${panel_fifo}"
    cnt_mpd=0
  fi

  # Finally, wait 1 second
  sleep 1s;

done &

#### LOOP FIFO

for geometry in $(xrandr | grep -Pow "connected[^\+]*\K\+[0-9]+\+[0-9]+"); do
	cat "${panel_fifo}" | $(dirname $0)/i3_lemonbar_parser.sh \
		| lemonbar -p -f "${font}" -f "${iconfont}" -g "${geometry}" -B "${color_back}" -F "${color_fore}" &
done

wait

