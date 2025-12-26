#!/usr/bin/env bash
tmux display -p "tmux-geticon.sh running..."
[[ ! -x /usr/bin/yq ]] && fatal "\"yq\" executable not found."
ICON="$1"
main() {
  local icons="$(tmux display -p "#{@LIB_ICON}")"
  local icon="$(yq e '.icons.[].$ICON' "${icons}" )" 
        
  echo ${icon}
}

fatal() {
  local e="$1"
  printf 'ERROR: %s\n' "${e}"
  exit 1
}
