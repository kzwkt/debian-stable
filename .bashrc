[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

#shopt -s globstar
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

PS1='\[\033[38;5;39m\]┌───(\[\033[38;5;36m\]\u㉿\h\[\033[38;5;39m\])─[\[\033[38;5;36m\]\w\[\033[38;5;39m\]]\n\[\033[38;5;39m\]└─\[\033[38;5;36m\]\$\[\033[0m\]'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sudo=doas
alias man=mman
export MANPAGER=less 

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi



# Check if bash completion is already sourced
if ! (shopt -q progcomp && type _init_completion &>/dev/null); then
    # Check if the default system-wide completion file exists and source it
    if [[ -f /etc/bash_completion ]]; then
        source /etc/bash_completion
    elif [[ -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    fi
fi

