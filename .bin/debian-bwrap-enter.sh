#!/usr/bin/env bash
set -euo pipefail

DEBIAN_ROOT="/run/media/kai/57ac1522-7e1d-44a0-aeac-e6b612fbd9f7"
DEBIAN_HOME="/run/media/kai/0987bbae-dbd8-49cc-8c49-cc702e4d979f"

[ -d "$DEBIAN_ROOT" ] || { echo "Error: root not found at $DEBIAN_ROOT" >&2; exit 1; }

HOST_UID="$(id -u)"
HOST_GID="$(id -g)"
XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$HOST_UID}"

args=(
  --unshare-user --unshare-pid --unshare-ipc --unshare-uts
  --die-with-parent
  --uid "$HOST_UID" --gid "$HOST_GID"

  # wipe the inherited environment; everything below is an allowlist
  --clearenv
  --setenv HOME /home/k
  --setenv USER k
  --setenv LOGNAME k
  --setenv SHELL /bin/bash
  --setenv PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
  --setenv TERM "${TERM:-xterm-256color}"
  --setenv LANG "${LANG:-C.UTF-8}"
  --setenv XDG_RUNTIME_DIR "$XDG_RUNTIME_DIR"

  --bind "$DEBIAN_ROOT" /
  --bind "$DEBIAN_HOME" /home
  --dev /dev
  --proc /proc
  --ro-bind /sys /sys
  --ro-bind-try /etc/resolv.conf /etc/resolv.conf

  # tmpfs first, then anything that lives under /tmp or /run
  --tmpfs /tmp
  --tmpfs /run
  --dir "$XDG_RUNTIME_DIR"
  --chmod 0700 "$XDG_RUNTIME_DIR"

  # GPU
  --dev-bind-try /dev/dri /dev/dri

  # X11
  --ro-bind-try /tmp/.X11-unix /tmp/.X11-unix

  # D-Bus
  --ro-bind-try "$XDG_RUNTIME_DIR/bus" "$XDG_RUNTIME_DIR/bus"
  --setenv DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus"
  --ro-bind-try /run/dbus/system_bus_socket /run/dbus/system_bus_socket

  # audio
  --ro-bind-try "$XDG_RUNTIME_DIR/pipewire-0" "$XDG_RUNTIME_DIR/pipewire-0"
  --ro-bind-try "$XDG_RUNTIME_DIR/pulse" "$XDG_RUNTIME_DIR/pulse"
)

# Wayland (only if present)
if [ -n "${WAYLAND_DISPLAY:-}" ] && [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; then
  args+=(--ro-bind "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"
         --setenv WAYLAND_DISPLAY "$WAYLAND_DISPLAY")
fi

# X11 (only if present)
if [ -n "${DISPLAY:-}" ]; then
  args+=(--setenv DISPLAY "$DISPLAY")
  if [ -n "${XAUTHORITY:-}" ] && [ -f "$XAUTHORITY" ]; then
    args+=(--ro-bind "$XAUTHORITY" /home/k/.Xauthority
           --setenv XAUTHORITY /home/k/.Xauthority)
  fi
fi

if [ $# -gt 0 ]; then
  exec bwrap --new-session "${args[@]}" "$@"
else
  exec bwrap "${args[@]}" /bin/bash --login
fi
