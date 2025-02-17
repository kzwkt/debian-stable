# monitor clipbard for change and save it to file 
#!/bin/bash

# File to log clipboard contents
LOG_FILE="/tmp/dl"

# Initial clipboard content
previous_clipboard=""

# Monitor clipboard for changes
while true; do
    # Get current clipboard content using xclip and ensure only plain text
    current_clipboard=$(xclip -o -selection clipboard -t TEXT)

    # Check if the clipboard content has changed
    if [ "$current_clipboard" != "$previous_clipboard" ]; then
        echo "$current_clipboard" >> "$LOG_FILE"  # Append to log with timestamp
        previous_clipboard="$current_clipboard"  # Update previous clipboard content
    fi

    sleep 1  # Check every second
done
