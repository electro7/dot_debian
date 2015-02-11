#! /bin/bash
#
# bar input parser for bspwm  Tuesday, 01 July 2014 22:57

#screen_width=$(sres -W)

. $(dirname $0)/i3_bar_config

while read -r line ; do
    case $line in
        S*)
            # conky
            sys_infos="${line#?}"
            ;;
        A*)
            # window title
            name=$(xprop -id ${line#?} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
            title="%{F${color_back} B${color_lgreen}} %{T2}Â%{R}Ú%{F- B- T-}${name}"
            ;;
    esac
    printf "%s\n" "%{%{l}${title} %{r}$sys_infos%{B-}"
    #printf "%s\n" "%{l B${color_sec_b1}}$wm_infos %{F${color_fore} B-}%{F-} %{c}${title} %{r}$sys_infos%{B-}"
done
