#######################################################################
# completion
#######################################################################

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit && compinit

#######################################################################
# history
#######################################################################

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

#######################################################################
# key bindings
#######################################################################

bindkey -e

if [ -f ~/.zshkeys ]; then
    source ~/.zshkeys
fi

#######################################################################
# options
# see here for list & explanations : http://zsh.sourceforge.net/Doc/Release/Options.html
#######################################################################

# completion
setopt AUTO_CD
setopt AUTO_MENU
setopt AUTO_PUSHD
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS

# history
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# IO
setopt CORRECT
setopt INTERACTIVE_COMMENTS

# scripts & functions
setopt C_BASES

#zle
unsetopt BEEP

# tab width
tabs -4

#######################################################################
# aliases
#######################################################################

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

#######################################################################
# open new terminal in same directory
#######################################################################

[ -f /etc/profile.d/vte.sh ] && source /etc/profile.d/vte.sh

#######################################################################
# zplug
#######################################################################

source ~/.zplugrc
