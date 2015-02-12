#! /bin/bash
#
# bar input parser for bspwm  Tuesday, 01 July 2014 22:57
# 

. $(dirname $0)/i3_bar_config

irc_n_high=0
initr="%{F${color_lgreen}}%{B${color_lgreen}}%{F-}"

while read -r line ; do
    case $line in
        DAT*)
          # Date
          date="%{F${color_sec_b1}}%{F${color_green} B${color_sec_b1}} %{T2}Õ%{F- T-} ${line#???} "
          ;;
        TIM*)
          # Time
          time="%{F${color_lgreen}}%{F${color_back} B${color_lgreen}} ${line#???} %{F- B-}"
          ;;
        SYS*)
          # conky
          sys_info="${line#???}"
          ;;
        VOL*)
          # Volume
          vol="%{F${color_sec_b2}}%{F${color_green} B${color_sec_b2}} %{T2}Ô%{F- T-} ${line#???}%% "
          ;;
        WIN*)
            # window title
            name=$(xprop -id ${line#???} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
            title="%{F${color_back} B${color_lgreen}}%{T2}Â%{R}Ú%{F- B- T-}${name}"
            ;;
        GMA*)
          # Gmail
          n_mail="${line#???}"
          if [ "${n_mail}" != "0" ]; then
            gmail="%{F${color_yellow}}%{F${color_back} B${color_yellow}} %{T2}Ó%{T-} ${n_mail} "
          else
            gmail="%{F${color_sec_b2}}%{F${color_green} B${color_sec_b2}} %{T2}Ó%{F- T-} ${n_mail} "
          fi
          ;;
        IRC*)
          # IRC highlight (script irc_warn)
          if [ "${line#???}" != "0" ]; then
            ((irc_n_high++))
            irc_high="${line#???}"
            irc="%{F${color_lred}}%{F${color_back} B${color_lred}} %{T2}Ò%{T-} ${irc_n_high}  %{T2}Á%{T-} ${irc_high} "
          else
            irc_n_high=0
            [ -z "${irc_high}" ] && irc_high="none"
            irc="%{F${color_sec_b1}}%{F${color_green} B${color_sec_b1}} %{T2}Ò%{F- T-} ${irc_n_high} %{F${color_green}} %{T2}Á%{F- T-} ${irc_high} "
          fi
          ;;
    esac
    printf "%s\n" "%{l}${title} %{r}${initr}${irc}${gmail}${sys_info}${vol}${date}${time}"
    #printf "%s\n" "%{l B${color_sec_b1}}$wm_infos %{F${color_fore} B-}%{F-} %{c}${title} %{r}$sys_infos%{B-}"
done
