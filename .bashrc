# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

## SHINEON STUFF ##
alias shine-sd="cd /Users/joeytyndale/Projects/shinedock"
alias shine-fd="cd /Users/joeytyndale/Projects/shopify-app"
alias shine-up="shine-sd && dc up -d caddy ngrok mysql mysql_client worker workspace"
alias shine-up-full="shine-sd && dc up -d"
alias shine-down="shine-sd && dc down"
alias shine-ws="shine-sd && dc exec workspace bash && shine-fd"
alias dc="docker-compose"
## Servers ##
alias aws-prod-http="ssh -i ~/.ssh/id_rsa ubuntu@ec2-52-87-0-100.compute-1.amazonaws.com"
alias aws-prod-worker="ssh -i ~/.ssh/id_rsa ubuntu@ec2-34-231-242-153.compute-1.amazonaws.com"
alias aws-prod-helper="ssh -i ~/.ssh/id_rsa ubuntu@ec2-34-199-92-207.compute-1.amazonaws.com"
# Helpful function to print these aliases
function shine-list {
echo "# ShineOn Aliases"
echo "shine-sd = 'cd /Users/joeytyndale/Projects/shinedock'"
echo "shine-fd = 'cd /Users/joeytyndale/Projects/shopify-app"
echo "shine-up = 'shine-sd && dc up -d caddy ngrok mysql mysql_client worker workspace'"
echo "shine-up-full = 'shine-sd && dc up -d'"
echo "shine-down = 'shine-sd && dc down'"
echo "shine-ws = 'shine-sd && dc exec workspace bash'"
}
# Function for updating shinedock - pass a tag to update to that tag (ex: shinedock-update v6)
function shinedock-update {
    shine-down
        if [ ! -z $1 ]; then
            git tag -d $1
        fi
    git pull origin $1
}

function find-string {
    grep -r ${1} -o | awk '!a[$0]++'
}

alias ls="ls -lah"
alias logreset="rm /Users/joeytyndale/Projects/shopify-app/storage/logs/laravel.log; touch /Users/joeytyndale/Projects/shineOn/shopify-app/storage/logs/laravel.log"
alias vopen="nvim -O \`fzf\`"
alias vo="vopen"
alias se="nvim -O \`git status | grep '^\s[a-z]:*\S*' | grep -oE '\S*$' | fzf \`"
alias branch="git checkout \`git branch --all | fzf\`"
alias nwatch="npm run watch-full >> .npmout"
alias e="nvim"
alias bashrc="nvim ~/.bashrc"
alias vimrc="nvim ~/.vimrc"
alias vim="nvim"
alias arty="./arty.sh"
alias gp="git pull"
alias gc="git commit"
alias gs="git status"
alias :q="echo 'You are not in Vim dude'"

##END ##

export PS1="\[\033[01;32m\]\u \[\033[00m\]> \[\033[01;34m\]\W\[$(tput sgr0)\] > \[\033[01;33m\]\$(git_branch)\[\033[00m\]\n$ "




eval "$(thefuck --alias)"



#eval "$(starship init bash)"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
alias config='/usr/bin/git --git-dir=/Users/joeytyndale/dotfiles --work-tree=/Users/joeytyndale'
