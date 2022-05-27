# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

LS_COLORS="di=1;33"

export SVN_EDITOR=vim

export GIT_EDITOR=vim

alias howbigis='du -hsc'
alias disk='df -h'
alias z='vim ~/.zshrc'
alias i3='vim ~/.i3/config'
alias termin='vim ~/.config/terminator/config'
alias ff='vifm .'
alias p='python3'
alias pi='python3 -i'
alias la='ls -al'
alias ll='ls -l'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"
plugins=(git wd colored-man-pages)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
