if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

## SHINEON STUFF ##
alias shine-sd="cd $HOME/Projects/shinedock"
alias shine-fd="cd $HOME/Projects/shopify-app"
alias shine-up="shine-sd && dc up -d caddy ngrok mysql mysql_client worker workspace"
alias shine-up-full="shine-sd && dc up -d"
alias shine-down="shine-sd && dc down"
alias shine-ws="shine-sd && dc exec workspace bash && shine-fd"
alias dc="docker-compose"
## Servers ##
alias aws-prod-http="ssh -i ~/.ssh/id_rsa ubuntu@ec2-52-87-0-100.compute-1.amazonaws.com"
alias aws-prod-worker="ssh -i ~/.ssh/id_rsa ubuntu@ec2-44-205-185-98.compute-1.amazonaws.com"
alias aws-prod-helper="ssh -i ~/.ssh/id_rsa ubuntu@ec2-34-199-92-207.compute-1.amazonaws.com"
alias aws-stage="ssh -i ~/.ssh/id_rsa ubuntu@ec2-3-87-228-34.compute-1.amazonaws.com"
alias ls="ls -lah"
alias logreset="rm $HOME/Projects/shopify-app/storage/logs/laravel.log; touch /Users/joeytyndale/Projects/shineOn/shopify-app/storage/logs/laravel.log"
alias vopen="nvim -O (fzf)"
alias vo="vopen"
alias se="nvim -O (git status | grep '^\s[a-z]:*\S*' | grep -oE '\S*\$' | fzf )"
alias branch="git checkout (git branch --all | grep -oE '\S*' | fzf)"
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
alias x="/usr/share/sddm/scripts/Xsetup"

alias config='/usr/bin/git --git-dir=$HOME/Projects/dotfiles.git --work-tree=$HOME'
alias hdmi='xrandr --output HDMI-1 --auto --primary --output eDP-1 --off'
alias dp-1='xrandr --output DP-1 --auto --primary --output eDP-1 --off'
alias dp-2='xrandr --output DP-2 --auto --primary --output eDP-1 --off'
alias dp-3='xrandr --output DP-3 --auto --primary --output eDP-1 --off'
alias dp-4='xrandr --output DP-4 --auto --primary --output eDP-1 --off'
alias laptop='xrandr --output eDP-1 --auto --primary --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output HDMI-1 --off'
starship init fish | source

thefuck --alias | source

set -x LESS -SRXF

set -Ua fish_user_paths ~/.config/composer/vendor/bin
set --universal fish_user_paths $fish_user_paths /usr/local/bin

# RUBY
set -gx fish_user_paths $fish_user_paths ~/.rvm/bin

# Load RVM into the shell
rvm default

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

function nb
  git branch -M $argv  # Create a new branch named by the argument (-M updates existing branch if it exists)
  git push -u origin $argv  # Push the newly created branch to remote origin
end
