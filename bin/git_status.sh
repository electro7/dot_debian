#
# Recorrer todos los directorios de trabajo y da el estado de GIT
#
# E7 - 23 sep 2019 


# Colors
c_gray="\033[0;37m"
c_d_gray="\033[1;30m"
c_red="\033[1;31m"
c_green="\033[1;32m"
c_yellow="\033[1;33m"
c_blue="\033[1;34m"
c_purple="\033[1;35m"
c_cyan="\033[1;36m"
c_none="\033[0m"

# Git status
# ---------------------------------------------------------------------------
function g_status() {
  set -- $(git rev-parse --abbrev-ref HEAD --is-inside-work-tree 2>/dev/null)
  local branch=$1
  local in_tree=$2

  # No .git in current dir -> exit
  if [ -z "$branch" ] || [ "$in_tree" != "true" ]
  then
    echo "$PWD : ${c_red}SIN GIT!! ¿?${c_none}"
    return 1
  fi

  # colors
  local c_branch="$c_blue"
  local c_add="$c_cyan"
  local c_clean="$c_green"
  local c_mod="$esc$c_yellow"
  local c_untrack="$c_red"
  local c_ahead="$c_purple"
  local c_begind="$c_purple"
  local c_none="$c_none"

  # Char for status
  local add_ch="●"
  local unmerged_ch="✘"
  local mod_ch="≈"
  local clean_ch="√"
  local untrack_ch="…"
  local ahead_ch="↑"
  local behind_ch="↓"

  local unmerged_c=0 mod_c=0 untrack=0
  local add_c=0 is_clean=""

  # Retrieve remote status
  set -- $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
  local behind_c=$1
  local ahead_c=$2

  # Current git chanhes in all files
  # Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R), changed (T),
  # Unmerged (U), Unknown (X), Broken (B)
  while read line; do
    case "$line" in
      M*) mod_c=$(( $mod_c + 1 )) ;;
      U*) unmerged_c=$(( $unmerged_c + 1 )) ;;
    esac
  done < <(git diff --name-status)

  # Current git chanhes in all files (cached)
  while read line; do
    case "$line" in
      *) add_c=$(( $add_c + 1 )) ;;
    esac
  done < <(git diff --name-status --cached)

  # List untrached file
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    untrack=1
  fi

  # Total count
  if [ $(( unmerged_c + mod_c + untrack + add_c )) -eq 0 ]
  then
    is_clean=1
  fi

  # Final status
  local lw_space=" "
  echo -ne "$PWD : ${c_branch}${branch}"
  [[ $ahead_c -gt 0 ]] \
    && echo -ne "${lw_space}${c_untrack}${ahead_ch}${ahead_c}"
  [[ $behind_c -gt 0 ]] \
    && echo -ne "${lw_space}${c_behind}${behind_ch}${behind_c}"
  [[ $mod_c -gt 0 ]] \
    && echo -ne "${lw_space}${c_mod}${mod_ch}${mod_c}"
  [[ $unmerged_c -gt 0 ]] \
    && echo -ne "${lw_space}${c_untrack}${unmerged_c}"
  [[ $add_c -gt 0 ]] \
    && echo -ne "${lw_space}${c_add}${dadd_ch}${add_c}"
  [[ $untrack -gt 0 ]] \
    && echo -ne "${lw_space}${c_untrack}${untrack_ch}"
  [[ $is_clean -gt 0 ]] \
    && echo -ne "${lw_space}${c_clean}${clean_ch}"
  echo -e "${c_none}"

}

# main
# ---------------------------------------------------------------------------
c_pwd=$PWD
g_dirs=$(find . -name .gitignore)

for D in ${g_dirs}
do
  cd $(dirname ${D})
  g_status
  cd ${c_pwd}
done


# vim: ts=2:sw=2:tw=0
