#!/usr/bin/env bash
mpris() {
    local command="$1"
    # Find all MPRIS-compatible media player
    local players=$(busctl --user list | grep 'org.mpris.MediaPlayer2' | awk '{print $1}')

if [ -z "$command" ]; then
        echo $players
        echo "Please provide a command next,play-pause,previous, stop)."
        return
    fi

if pgrep -x "mpv" > /dev/null; then
        case "$command" in
            "Next")
                echo "script-binding uosc/next" | socat - /tmp/mpv
                return
                ;;
            "Previous")
                echo "script-binding uosc/prev" | socat - /tmp/mpv
                return
                ;;
            "PlayPause")
                 echo "cycle pause" | socat - /tmp/mpv
        esac
    fi

    # Send the corresponding command to each found mpris instance
    for instance in $players; do
        busctl --user call "$instance" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player "$command"
    done
}


case "$1" in
	"next") mpris "Next" ;;
        "play-pause") mpris "PlayPause" ;;
        "previous") mpris "Previous" ;;
        "stop") mpris "Stop" ;;
        *) mpris ;;
    esac


