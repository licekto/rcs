# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Allow for "**" globbing
shopt -s globstar

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

PATH="/home/tomas/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/tomas/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/tomas/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/tomas/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/tomas/perl5"; export PERL_MM_OPT;

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
alias gs='git status'
alias gl='git log --graph'
alias gds='git diff && git status'
alias gas='git add . && git status'
alias gc='git commit -m'
alias gp='git push'
alias gch='git checkout'
alias gchm='git checkout master'
alias gpu='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias gpl='git pull'
alias gsu='git submodule update'
alias gu='git pull && git submodule update'
alias gf='git commit --fixup=`git rev-parse HEAD`'
alias gb='git checkout -b'
alias gr='git remote -v'

addCommitPush ()
{
    if [ -z "$1" ] ; then
        echo "Commit message must not by empty"
        return
    fi

    CHANGES=`git diff --exit-code`

    if [ -z "$CHANGES" ] ; then
        echo "No changes to commit"
        return
    fi

    git add .
    git commit -m "$1"
    git push
}

alias gacp='addCommitPush'

# Compile
alias gxx='g++ -pedantic -Wall -Wextra -Weffc++ -std=c++1z -ggdb -O0'
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
