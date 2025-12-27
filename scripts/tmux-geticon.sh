#!/usr/bin/env bash
DEBUG=0
(( DEBUG != 0 )) && tmux display -p "tmux-geticon.sh running..."

[[ ! -x /usr/bin/yq ]] && fatal "\"yq\" executable not found."
[[ -n "$1" ]] && ICON="$1" || ICON="fallback-icon"

main() {
  local icons="$(tmux display -p "#{@LIB_ICON}")"
  local icon="$(yq e ".icons.[].$ICON" "${icons}" | grep -v "null" )" 
  (( $? != 0 )) && fatal "yq failed to get icon. Check paths and config"        
  result "${icon}" 
}

result() {
  local icon="$1"
  if (( DEBUG == 1 )); then
    tmux display -p "tmux-geticon: Icon: ${icon}"
  else
    echo "${icon}"
  fi
}


fatal() {
  local e="$1"
  printf 'ERROR: %s\n' "${e}"
  exit 1
}

main

