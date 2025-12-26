#!/usr/bin/env bash
usage="${0##*/}"
tmux setenv '@PLUG_ROOT' "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$PLUG_ROOT="$(tmux display -p "#{@PLUG_ROOT}")"
$ICONS="$(tmux display -p "#{@LIB_ICON}")"
tmux display "#[align=centre]tmux-geticon.sh running..."
$PLUG_ROOT/scripts/tmux-metaphile.sh
tmux bind M-I run "$PLUG_ROOT/tmux-geticon"
