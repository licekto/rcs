# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Allow for "**" globbing
shopt -s globstar

# Disable suspending the terminal with CTRL+S
stty -ixon

#PS1='[\u@\h \W]\$ '

#PS1="┌─[\`if [ \$? = 0 ]; then echo \[\e[32m\]✔\[\e[0m\]; else echo \[\e[31m\]✘\[\e[0m\]; fi\`]───[\[\e[01;49;39m\]\u\[\e[00m\]\[\e[01;49;39m\]@\H\[\e[00m\]]───[\[\e[1;49;34m\]\W\[\e[0m\]]───[\[\e[1;49;39m\]\$(ls | wc -l) files, \$(ls -lah | grep -m 1 total | sed 's/total //')\[\e[0m\]]\n└───▶ "

RED="\[\e[0;36m\]"
GRAY="\[\e[0;37m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
GREEN="\[\e[0;32m\]"
WHITE="\[\e[0;37m\]"
BLOODRED="\[\e[1;31m\]"
CYAN="\[\e[1;34m\]"
LIGHT_CYAN="\[\e[0;96m\]"
LIGHT_GREEN="\[\e[1;32m\]"
TXTRST="\[\e[0m\]"

DOWNBAR='\342\224\214'
HORBAR='\342\224\200'
UPBAR='\342\224\224'
HORBARPLUG='\342\225\274'
CROSS='\342\234\227'
TICK='\342\234\224'

function parse_git_dirty
{
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}

function parse_git_branch
{
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function git_module
{
    if [[ $(git status 2> /dev/null) ]];then
        echo $WHITE$HORBAR[$PURPLE$(parse_git_branch)$WHITE];
    fi
 }

function file_module
{
    echo $HORBAR[$CYAN$(ls | wc -l) files, $(ls -lah | grep -m 1 total | sed 's/total //')$WHITE]
}

function end_module
{
#    echo "\n"$WHITE$UPBAR$HORBAR$HORBAR$HORBARPLUG $TXTRST
    echo '\$' $TXTRST
}

function retval_module
{
    RETVAL=$?
#    BEGIN=$WHITE$DOWNBAR$HORBAR
    BEGIN=$WHITE$HORBAR
    if [[ $RETVAL != 0 ]]; then
	echo $BEGIN[$BLOODRED$CROSS$WHITE]
    else
	echo $BEGIN[$GREEN$TICK$WHITE]
    fi
}

function user_module
{
#     echo $HORBAR[$(if [[ ${EUID} == 0 ]]; then echo $BLOODRED'\h'; else echo $YELLOW'\u'$GRAY'@'$LIGHT_CYAN'\h'; fi)$WHITE]
     echo $HORBAR[$(if [[ ${EUID} == 0 ]]; then echo $BLOODRED; else echo $YELLOW; fi)'\u'$WHITE]
}

function location_module
{
    echo $HORBAR[$LIGHT_GREEN'\w'$WHITE]
}

function set_bash_prompt
{
#PS1=$(retval_module)$(user_module)$(location_module)$(git_module)$(file_module)$(end_module)
    PS1=$(retval_module)$(user_module)$(location_module)$(git_module)$(end_module)
}

PROMPT_COMMAND=set_bash_prompt

# Extract
extract ()
{
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

export -f extract

# Git
alias gpu='git push -u origin `git rev-parse --abbrev-ref HEAD`'

add_commit_push ()
{
    if [ -z "$1" ] ; then
        echo "Commit message must not by empty"
        return
    fi

    CHANGES=$(git diff --exit-code && git ls-files . --others)

    if [ -z "$CHANGES" ] ; then
        echo "No changes to commit"
        return
    fi

    git add .
    git commit -m "$1"
    gpu
}

alias gacp='add_commit_push'
alias gas='git add . && git status'
alias gash='git stash'
alias gashc='git stash clear'
alias gb='git checkout -b'
alias gblrm='git branch -D'
alias gbrrm='git push origin --delete'
alias gc='git commit -m'
alias gch='git checkout .'
alias gchm='git checkout master'
alias gds='git diff && git diff --check && git status'
alias gf='git commit --fixup=`git rev-parse HEAD`'
alias gl='git log --graph -7 --oneline'
alias gp='git push'
alias gpull='git pull'
alias gr='git remote -v'
alias gria='git rebase --interactive --autosquash'
alias grm='git clean -f'
alias grmcheck='git clean -n'
alias gs='git status'
alias gsu='git submodule update'
alias gu='git pull && git submodule update'
alias gunstage='git reset HEAD'

# Compile
alias gxx='g++ -pedantic -Wall -Wextra -Weffc++ -std=c++17 -ggdb -O0'
alias valgrindxx='valgrind --leak-check=full --show-reachable=yes --track-origins=yes'

# Command-line
alias setclip='xclip -selection c'
alias c.='cd ..'
alias c..='cd ../..'
alias c...='cd ../../..'
alias v='vim'
alias ls='ls --color=auto'
alias l='ls -lSh'
alias la='l -a'
alias diskspace='du -S | sort -n -r |more'

# Vim as a default editor
export EDITOR=vim

# Download mp3 from youtube
alias dl-yt='youtube-dl --extract-audio --audio-format mp3'

# Docker

docker_clean() {
    docker kill $(docker ps -q)
    docker rm $(docker ps -aq)
    docker rmi $(docker images -q)
}

alias dckr-clean='docker_clean'
