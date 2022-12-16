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
alias config='/usr/bin/git --git-dir=/Users/joeytyndale/dotfiles --work-tree=/Users/joeytyndale'
#eval "$(thefuck --alias)"


eval "$(starship init bash)"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
