#!/bin/sh
# Hybrid_e7 - Shell color setup script
# Script based in https://github.com/chriskempson/base16-shell
# E7 - 28 ene 2015

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="28/2a/2e" # Black
color01="a5/42/42" # Red
color02="8c/94/40" # Green
color03="de/93/5f" # Yellow
color04="5f/81/9d" # Blue
color05="85/67/8f" # Magenta
color06="5e/8d/87" # Cyan
color07="70/78/80" # White
color08="37/3b/41" # Bright Black
color09="cc/66/66" # Bright Red
color10="b5/bd/68" # Bright Green
color11="f0/c6/74" # Bright Yellow
color12="81/a2/be" # Bright Blue
color13="b2/94/bb" # Bright Magenta
color14="8a/be/b7" # Bright Cyan
color15="c5/c8/c6" # Bright White
color16="81/a2/e1" # Extra blue
color17="8a/cb/b7" # Extra cyan
color18="bd/4b/4b" # Extra red
color19="1d/1f/21" # Extra Black 1
color20="2b/2e/30" # Extra Black 2
color21="d5/d9/d7" # Extra White 1
color_foreground="c5/c8/c6" # Foreground
color_background="1d/1f/21" # Background
color_cursor="c3/ff/00"     # Cursor color 

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg c5c8c6 # foreground
  printf $printf_template_custom Ph 1d1f21 # background
  printf $printf_template_custom Pi d8d8d8 # bold color
  printf $printf_template_custom Pj 383838 # selection color
  printf $printf_template_custom Pk d8d8d8 # selected text color
  printf $printf_template_custom Pl d8d8d8 # cursor
  printf $printf_template_custom Pm 181818 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_var 12 $color_cursor
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor
