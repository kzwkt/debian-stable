# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
    PATH="/sbin:$HOME/.bin:$PATH"

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec sway
fi
