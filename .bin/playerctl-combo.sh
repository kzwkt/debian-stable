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

if command -v busctl >/dev/null; then
players=$(busctl --user list | grep 'org.mpris.MediaPlayer2' | awk '{print $1}')
runn(){
busctl --user call "$1" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player "$2"
}
elif command -v dbus-send >/dev/null; then
players=$(dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep 'org.mpris.MediaPlayer2' | awk -F '"' '{print $2}')
runn(){
dbus-send --session --dest="$1" --type=method_call /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player."$2"
}
else
echo "Neither busctl nor dbus-send found." >&2
return 1
fi

for x in $players; do
runn "$x" "$1"
done
}


case "$1" in
"next") mpris "Next" ;;
"play-pause") mpris "PlayPause" ;;
"previous") mpris "Previous" ;;
"stop") mpris "Stop" ;;
*) exit 1  ;;
esac
