# .zshrc

autoload -Uz vcs_info
autoload -U zmv

setopt prompt_subst
setopt interactivecomments
setopt extended_glob

precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%b"

is_git()
{
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) ]]
    then
        printf "-[%%F{cyan}${vcs_info_msg_0_}%%f]"
    fi
}

PS1='-[%(?.%F{green}o%f.%B%F{red}x%f)]-[%F{blue}%n%f]-[%F{green}%d%f]$(is_git)$ '

bindkey "\033[H" beginning-of-line
bindkey "\033[F" end-of-line
