#!/bin/bash

WOBSOCK=/tmp/wob.sock
rm -f "$WOBSOCK"
mkfifo "$WOBSOCK"
tail -f "$WOBSOCK" | wob 2>/tmp/wob.log &

case $1 in
    vup) amixer sset Master 5%+ | sed -En 's/.*\[([0-9]+)%\].*/\1/p' | head -1 > "$WOBSOCK" ;;
    vdown) amixer sset Master 5%- | sed -En 's/.*\[([0-9]+)%\].*/\1/p' | head -1 > "$WOBSOCK" ;;
    vmute) amixer sset Master toggle | sed -En '/\[on\]/ s/.*\[([0-9]+)%\].*/\1/p; /\[off\]/ s/.*/0/p' > "$WOBSOCK" ;;
    bup) brightnessctl set -e 1%+ | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > "$WOBSOCK" ;;
    bdown) brightnessctl set -e 1%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > "$WOBSOCK" ;;
esac
sleep 5
pkill wob  
exit 0
