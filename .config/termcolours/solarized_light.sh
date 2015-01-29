#!/bin/sh
# solarized_light - Shell color setup script
# Script based in https://github.com/chriskempson/base16-shell
# E7 - 28 ene 2015

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="ee/e8/d5" # Black
color01="dc/32/2f" # Red
color02="85/99/00" # Green
color03="b5/89/00" # Yellow
color04="26/8d/d2" # Blue
color05="d3/36/82" # Magenta
color06="2a/a1/98" # Cyan
color07="07/36/42" # White
color08="fd/f6/e3" # Bright Black
color09="cb/4d/12" # Bright Red
color10="93/a1/a1" # Bright Green
color11="83/94/96" # Bright Yellow
color12="65/7b/83" # Bright Blue
color13="6c/71/c4" # Bright Magenta
color14="58/6e/75" # Bright Cyan
color15="00/2b/36" # Bright White
color_foreground="65/7b/83" # Foreground
color_background="fd/f6/e3" # Background
color_cursor="58/6e/75"     # Cursor color 
   
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
unset color_foreground
unset color_background
unset color_cursor
