#!/usr/bin/env bash

MPV_SOCKET="/tmp/mpv"
RESET="\e[0m"
FG_ACTIVE="\e[93m"
FG_INACTIVE="\e[90m"

to_cmp_time() {
    t="$1"
    [[ -z "$t" ]] && echo 0 && return
    int="${t%%.*}"; frac="${t#*.}0000"; echo $((10#$int * 10000 + 10#${frac:0:4}))
}

while :; do
    echo -ne "\e[?25l"
    [[ ! -S "$MPV_SOCKET" ]] && sleep 1 && continue

    song_path=$(echo '{"command":["get_property","path"]}' | nc -U -N "$MPV_SOCKET" 2>/dev/null | sed -n 's/.*"data":"\([^"]*\)".*/\1/p')
    [[ -z "$song_path" ]] && sleep 1 && continue

    song_base="${song_path##*/}"
    song_dir="${song_path%/*}"
    song_name="${song_base%.*}"
    lrc_path="$song_dir/$song_name.lrc"

    [[ ! -f "$lrc_path" ]] && sleep 1 && continue

    times=(); lines=()
    while IFS= read -r line; do
        while [[ "$line" =~ \[([0-9]+):([0-9]+)(\.([0-9]+))?\] ]]; do
            min=${BASH_REMATCH[1]}; sec=${BASH_REMATCH[2]}; frac=${BASH_REMATCH[4]:-0}
            ts=$(printf "%d.%02d" $((10#$min * 60 + 10#$sec)) $((10#$frac)))
            times+=("$ts")
            line="${line#*\]}"
        done
        lines+=("$line")
    done < "$lrc_path"

    last_idx=-1
    prev_time=0
    clear

    while :; do
        new_path=$(echo '{"command":["get_property","path"]}' | nc -U -N "$MPV_SOCKET" 2>/dev/null | sed -n 's/.*"data":"\([^"]*\)".*/\1/p')
        [[ "$new_path" != "$song_path" ]] && break

        time=$(echo '{"command":["get_property","time-pos"]}' | nc -U -N "$MPV_SOCKET" 2>/dev/null | sed -n 's/.*"data":\([^}]*\).*/\1/p')
        [[ -z "$time" || "$time" == "null" ]] && sleep 0.05 && continue
        cmp_time=$(to_cmp_time "$time")
        (( cmp_time - prev_time < 50 )) && sleep 0.01 && continue
        prev_time=$cmp_time

        idx=-1
        for ((i = 0; i < ${#times[@]}; i++)); do
            [[ $(to_cmp_time "${times[i]}") -le $cmp_time ]] && idx=$i
        done
        (( idx < 0 )) && sleep 0.01 && continue

        start=$(to_cmp_time "${times[idx]}")
        end=$(( idx + 1 < ${#times[@]} ? $(to_cmp_time "${times[idx+1]}") : start + 30000 ))
        elapsed=$((cmp_time - start))
        duration=$((end - start))
        (( duration <= 0 )) && duration=1
        percent=$((elapsed * 100 / duration))
        (( percent > 100 )) && percent=100
        (( percent < 0 )) && percent=0

        line="${lines[idx]}"
        IFS=' ' read -ra words <<< "$line"
        total=0; weight=()
        for w in "${words[@]}"; do
            l=${#w}; weight+=($l); total=$((total + l))
        done
        current=$((percent * total / 100))
        acc=0; out=""

        for ((j = 0; j < ${#words[@]}; j++)); do
            w="${words[j]}"; l=${weight[j]}
            if (( acc + l <= current )); then
                out+="${FG_ACTIVE}${w} ${RESET}"
            elif (( acc >= current )); then
                out+="${FG_INACTIVE}${w} ${RESET}"
            else
                p=$((current - acc))
                out+="${FG_ACTIVE}${w:0:p}${RESET}${FG_INACTIVE}${w:p} ${RESET}"
            fi
            acc=$((acc + l))
        done

        if (( idx != last_idx || percent % 5 == 0 )); then
            clear
            tput cup 2 5
            echo -e "$out"
        fi

        last_idx=$idx
        sleep 0.01
    done
done
