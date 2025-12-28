#!/usr/bin/env bash
ICON="$1"
DEBUG=1
ICONS='$(tmux display -p \"#{@LIB_ICON}\")'
(( DEBUG == 1 )) && tmux display -p "tmux-geticon.sh running..."
[[ ! -x /usr/bin/yq ]] && fatal "\"yq\" executable not found."
[[ ! -n "$ICON" ]] && ICON="default"

main() {
  local icon="$(yq ".icons.[].$ICON" "${ICONS}" | grep -v "null" )" 
  (( $? != 0 )) && fatal "yq failed to get icon. Check paths and config"        
  result "$icon" 
}

result() {
  local ico="$1"
  echo "${ico}"
}

fatal() {
  local e="$1"
  printf 'ERROR: %s\n' "${e}"
  exit 1
}

main
