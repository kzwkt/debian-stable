#!/bin/sh

# Start PipeWire if not already running
if ! pgrep -x pipewire >/dev/null 2>&1; then
    pipewire &
fi

# Start WirePlumber if not already running
if ! pgrep -x wireplumber >/dev/null 2>&1; then
    wireplumber &
fi

# Optional: Start PulseAudio compatibility if desired
if ! pgrep -x pipewire-pulse >/dev/null 2>&1; then
    pipewire-pulse &
fi
