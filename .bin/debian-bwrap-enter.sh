#!/usr/bin/env bash

DEBIAN_ROOT="/run/media/kai/57ac1522-7e1d-44a0-aeac-e6b612fbd9f7"
DEBIAN_HOME="/run/media/kai/0987bbae-dbd8-49cc-8c49-cc702e4d979f"

HOST_UID="$(id -u)"
HOST_GID="$(id -g)"

if [ ! -d "$DEBIAN_ROOT" ]; then
    echo "Error: Root path not found at $DEBIAN_ROOT"
    exit 1
fi

XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$HOST_UID}"

bwrap \
  --unshare-user \
  --uid "$HOST_UID" \
  --gid "$HOST_GID" \
  --bind "$DEBIAN_ROOT" / \
  --bind "$DEBIAN_HOME" /home \
  --dev /dev \
  --proc /proc \
  --ro-bind /sys /sys \
  --ro-bind /etc/resolv.conf /etc/resolv.conf \
  --ro-bind /tmp/.X11-unix /tmp/.X11-unix \
  --ro-bind "$XAUTHORITY" /home/k/.Xauthority \
  --tmpfs /tmp \
  --tmpfs /run \
  --dir "$XDG_RUNTIME_DIR" \
  --ro-bind "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" \
  --ro-bind "$XDG_RUNTIME_DIR/bus" "$XDG_RUNTIME_DIR/bus" \
  --setenv DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus" \
  --setenv DISPLAY "$DISPLAY" \
  --setenv HOME /home/k \
  --setenv PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin \
  --setenv TERM "${TERM:-xterm-256color}" \
  --setenv USER k \
  --setenv WAYLAND_DISPLAY "$WAYLAND_DISPLAY" \
  --setenv XAUTHORITY /home/k/.Xauthority \
  --setenv XDG_RUNTIME_DIR "$XDG_RUNTIME_DIR" \
  /bin/bash --login
  
