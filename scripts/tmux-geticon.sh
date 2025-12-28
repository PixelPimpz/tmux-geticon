#!/usr/bin/env bash
DEBUG=1

[[ ! -x /usr/bin/yq ]] && fatal "\"yq\" executable not found."
[[ -n "$1" ]] && ICON="$1" || ICON="default"

main() {
  local icons="$(tmux display -p "#{@LIB_ICON}")"
  local icon="$(yq ".icons.[].$ICON" "${icons}" | grep -v "null" )" 
  (( $? != 0 )) && fatal "yq failed to get icon. Check paths and config"        
  if (( DEBUG != 0 )); then
    tmux display -p "tmux-geticon.sh running..."
    tmux display -p ">> ICON: $ICON"
    tmux display -p ">> Icon: ${icon}"
  fi
  result "$icon" 
}

result() {
  local icon="$1"
  echo "${icon}"
}

fatal() {
  local e="$1"
  printf 'ERROR: %s\n' "${e}"
  exit 1
}

main
