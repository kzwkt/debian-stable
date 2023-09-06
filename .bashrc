# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:~/.bin/
export PS1='\n\[\033[0;32m\]\u@\h \[\033[1;33m\]\w\n\[\033[0m\]>'

#export TERM=foot
#export WLR_RENDERER=vulkan

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

HISTCONTROL=ignoredups:erasedups


alias man=mman
alias condaa="source  /home/kai/opt/miniconda3/etc/profile.d/conda.sh"

if [ "$TERM" != "dumb" ]; then
#alias ls='ls --color=auto'
#alias ll='ls --color=auto -lah'
#alias la='ls --color=auto -A'

#alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
#alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
#alias ll='exa -l --color=always --group-directories-first --icons'  # long format
#alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
#alias l.='exa -ald --color=always --group-directories-first --icons .*' # show only dotfiles

#alias cat='batcat'

alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias zgrep='zgrep --color=always'
alias less='less -R'
fi

export PAGER="/usr/bin/less -R"
export EDITOR=nano
export VISUAL=nano


#[ "$(tty)" = "/dev/tty1" ] && exec sway
