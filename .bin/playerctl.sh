#!/usr/bin/env bash
[ -z "$1" ] && { echo "Please provide a command (next, play-pause, previous, stop)."; exit 1; }

pgrep -x "mpv" > /dev/null && {
mpc() { echo "$1" | socat - /tmp/mpv; exit 0; }
case "$1" in
"next") mpc "script-binding uosc/next" ;;
"previous") mpc "script-binding uosc/prev" ;;
"play-pause") mpc "cycle pause"  ;;
*) exit 1 ;;
esac
}


mpris() {
players=$(busctl --user list | grep 'org.mpris.MediaPlayer2' | awk '{print $1}')
for x in $players; do
busctl --user call "$x" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player "$1"
done
}

case "$1" in
"next") mpris "Next" ;;
"play-pause") mpris "PlayPause" ;;
"previous") mpris "Previous" ;;
"stop") mpris "Stop" ;;
*) exit 1  ;;
esac
