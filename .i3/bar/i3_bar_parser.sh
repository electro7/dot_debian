#! /bin/bash
#
# bar input parser for bspwm  Tuesday, 01 July 2014 22:57
# 

. $(dirname $0)/i3_bar_config

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
    esac
    printf "%s\n" "%{l}${title} %{r}${sys_info}${vol}${date}${time}"
    #printf "%s\n" "%{l B${color_sec_b1}}$wm_infos %{F${color_fore} B-}%{F-} %{c}${title} %{r}$sys_infos%{B-}"
done
