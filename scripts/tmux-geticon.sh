#!/usr/bin/env bash
tmux display -p "tmux-geticon.sh running..."
[[ ! -x /usr/bin/yq ]] && fatal "\"yq\" executable not found."
[[ -n "$1" ]] && ICON="$1" || ICON="fallback-icon"

main() {
  local icons="$(tmux display -p "#{@LIB_ICON}")"
  local icon="$(yq e '.icons.[].alert' "${icons}" | grep -v "null" )" 
  (( $? != 0 )) && fatal "yq failed to get icon. Check paths and config"        
  tmux display -p "${icon}"
}

fatal() {
  local e="$1"
  printf 'ERROR: %s\n' "${e}"
  exit 1
}

main

