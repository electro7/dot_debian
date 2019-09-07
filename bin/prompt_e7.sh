#
# My bash prompt using PROMPT_COMMAND to change PS1
#
#   - ssh conection
#   - working directory
#   - git status
#   - Current normaluser/root
#
# E7 - 05 sep 2019


# Colors
c_gray=$(tput setaf 7);
c_d_gray=$(tput setaf 8);
c_red=$(tput setaf 9)
c_green=$(tput setaf 10)
c_yellow=$(tput setaf 11)
c_blue=$(tput setaf 12)
c_purple=$(tput setaf 13)
c_cyan=$(tput setaf 14)
c_none=$(tput sgr0)

# Prompt init
# ---------------------------------------------------------------------------
function __prompt_e7_init {
  # Terminal window title
  local title=""
  if [ -z "$TW_TITLE" ]; then
    title='\[\e]0;\h : \s (\w)\a\]'
  else
    title="${TW_TITLE}"
  fi
  # Remote conection ?
  local prompt_init=""
  if [ -n "$SSH_CONNECTION" ]; then
    prompt_init="$title${c_d_gray}┌[${c_yellow}\h${c_d_gray}]─[${c_gray}\w${c_d_gray}]"
  else
    prompt_init="$title${c_d_gray}┌[${c_gray}\w${c_d_gray}]"
  fi

  printf "%s" "${prompt_init}"
}

# Prompt end
# ---------------------------------------------------------------------------
function __prompt_e7_end {
  local c_who=${c_cyan}
  [[ "$UID" = "0" ]] && c_who=${c_red}
  prompt_end="\n${c_d_gray}└ ${c_who}\\$ ${c_none}"

  printf "%s" "${prompt_end}"
}

# Git status
# ---------------------------------------------------------------------------
function __prompt_e7_git_status {
  set -- $(git rev-parse --abbrev-ref HEAD --is-inside-work-tree 2>/dev/null)
  local branch=$1
  local in_tree=$2

  # No .git in current dir -> exit
  if [ -z "$branch" ] || [ "$in_tree" != "true" ]
  then
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
  printf "%s" "${c_d_gray}─[${c_branch}${branch}"
  [[ $ahead_c -gt 0 ]] \
    && printf "%s" "${lw_space}${c_untrack}${ahead_ch}${ahead_c}"
  [[ $behind_c -gt 0 ]] \
    && printf "%s" "${lw_space}${c_behind}${behind_ch}${behind_c}"
  [[ $mod_c -gt 0 ]] \
    && printf "%s" "${lw_space}${c_mod}${mod_ch}${mod_c}"
  [[ $unmerged_c -gt 0 ]] \
    && printf "%s" "${lw_space}${c_untrack}${unmerged_c}"
  [[ $add_c -gt 0 ]] \
    && printf "%s" "${lw_space}${c_add}${dadd_ch}${add_c}"
  [[ $untrack -gt 0 ]] \
    && printf "%s" "${lw_space}${c_untrack}${untrack_ch}"
  [[ $is_clean -gt 0 ]] \
    && printf "%s" "${lw_space}${c_clean}${clean_ch}"
  printf "%s" "${c_d_gray}]${c_none}"

}

# main
# ---------------------------------------------------------------------------
function __prompt_e7 {
  PS1="$(__prompt_e7_init)$(__prompt_e7_git_status)$(__prompt_e7_end)"

}

if [[ ! "$PROMPT_COMMAND" == *__prompt_e7* ]]; then
    PROMPT_COMMAND='__prompt_e7;'
fi

#__prompt_e7

# vim: ts=2:sw=2:tw=0
