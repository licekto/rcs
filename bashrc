# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	 . /etc/bashrc
fi

if [ -f /etc/bash.bashrc ]; then
	 . /etc/bash.bashrc
fi

# Allow for "**" globbing
shopt -s globstar

# Disable suspending the terminal with CTRL+S
stty -ixon

# Allow parallel history
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
HISTSIZE=100000
HISTFILESIZE=100000

#PS1='[\u@\h \W]\$ '

#PS1="┌─[\`if [ \$? = 0 ]; then echo \[\e[32m\]✔\[\e[0m\]; else echo \[\e[31m\]✘\[\e[0m\]; fi\`]───[\[\e[01;49;39m\]\u\[\e[00m\]\[\e[01;49;39m\]@\H\[\e[00m\]]───[\[\e[1;49;34m\]\W\[\e[0m\]]───[\[\e[1;49;39m\]\$(ls | wc -l) files, \$(ls -lah | grep -m 1 total | sed 's/total //')\[\e[0m\]]\n└───▶ "

RED='\[\e[0;36m\]'
GRAY='\[\e[0;37m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
PURPLE='\[\e[0;35m\]'
GREEN='\[\e[0;32m\]'
WHITE='\[\e[0;37m\]'
BLOODRED='\[\e[1;31m\]'
CYAN='\[\e[1;34m\]'
LIGHT_CYAN='\[\e[0;96m\]'
LIGHT_GREEN='\[\e[1;32m\]'
TXTRST='\[\e[0m\]'

DOWNBAR='\[\342\224\214\]'
#HORBAR="\342\224\200"
HORBAR='-'
UPBAR='\[\342\224\224\]'
HORBARPLUG='\[\342\225\274\]'
#CROSS='\[\342\234\227\]'
#TICK='\[\342\234\224\]'
CROSS='x'
TICK='o'

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
    BEGIN=$WHITE$HORBAR
    BEGIN=$HORBAR
    if [[ $RETVAL != 0 ]]; then
	echo $BEGIN[$BLOODRED$CROSS$WHITE]
    else
	echo $BEGIN[$GREEN$TICK$WHITE]
    fi
}

function user_module
{
     echo $HORBAR[$(if [[ ${EUID} == 0 ]]; then echo $BLOODRED'\h'; else echo $YELLOW'\u'$GRAY'@'$LIGHT_CYAN'\h'; fi)$WHITE]
#     echo $HORBAR[$(if [[ ${EUID} == 0 ]]; then echo $BLOODRED; else echo $YELLOW; fi)'\u'$WHITE]
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

# Vim as a default editor
export VISUAL=vim
export EDITOR=vim
export VIEWER=~/.rcs/viewer.sh
