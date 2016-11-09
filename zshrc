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

case "$(uname -s)" in
    Linux)
        zstyle :compinstall filename '/home/acormier/.zshrc'
        ;;
    Darwin)
        zstyle :compinstall filename '/Users/acormier/.zshrc'
        ;;
esac

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
# syntax highlighting
#######################################################################

case "$(uname -s)" in
    Linux)
        if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
            source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        fi
        ;;
    Darwin)
        brew_prefix="$(brew --prefix 2> /dev/null)"

        if [ -d $brew_prefix/share/zsh-completions ]; then
            fpath=($brew_prefix/share/zsh-completions $fpath)
        fi

        if [ -f $brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
            source $brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        fi
        ;;
esac

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

#######################################################################
# prompts
#######################################################################

autoload -U colors && colors

setopt PROMPT_SUBST

function git_prompt {
    command -v git > /dev/null 2>&1 || return
    if [ -d .git ] || git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        detached=0
        added=0
        deleted=0
        deleted_staged=0
        modified=0
        modified_staged=0
        untracked=0

        commit_hash="$(git rev-parse --short HEAD 2> /dev/null)"
        git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
        if [[ "$git_branch" == "HEAD" ]]; then
            detached=1
            [[ -n "$commit_hash" ]] && git_branch="$commit_hash"
        fi

        git status --porcelain | cut -c 1-2 | while IFS= read s; do
            case $s in
                'A ') ((++added)) ;;
                ' D') ((++deleted)) ;;
                'D ') ((++deleted_staged)) ;;
                ' M') ((++modified)) ;;
                'M ') ((++modified_staged)) ;;
                '??') ((++untracked)) ;;
            esac
        done

        git_unstaged=''
        [ $untracked -ne 0 ] && git_unstaged+='%F{green}○'
        [ $modified -ne 0 ] && git_unstaged+='%F{yellow}○'
        [ $deleted -ne 0 ] && git_unstaged+='%F{red}○'
        [ -n "$git_unstaged" ] && git_unstaged="|${git_unstaged}%f"

        git_staged=''
        [[ $added -ne 0 ]] && git_staged+='%F{green}●'
        [[ $modified_staged -ne 0 ]] && git_staged+='%F{yellow}●'
        [[ $deleted_staged -ne 0 ]] && git_staged+='%F{red}●'
        [[ -n "$git_staged" ]] && git_staged="|${git_staged}%f"

        git_divergence=''
        if [ $detached -eq 0 ]; then
            ahead=0
            behind=0
            if rev_list="$(git rev-list --left-right $git_branch@{u}... 2> /dev/null)"; then
                echo $rev_list | cut -c 1 | while read s; do
                    case $s in
                        '>') ((++ahead)) ;;
                        '<') ((++behind)) ;;
                    esac
                done
                git_divergence="|%F{green}↑${ahead}%F{red}↓${behind}%f"
            fi
        fi

        echo "[%F{cyan}${git_branch}%f${git_unstaged}${git_staged}${git_divergence}]"
    fi
}

PROMPT='
[%(#,%F{red},%F{green})%n%f@%(#,%F{red},%F{green})%m%f][%F{magenta}%~%f]$(git_prompt)
%(?,%(#,%F{cyan},%F{blue}),%F{red})>>>%f '
PROMPT2='%(?,%(#,%F{cyan},%F{blue}),%F{red})  >%f '
PROMPT3='%(?,%(#,%F{cyan},%F{blue}),%F{red})  >%f '
PROMPT4='%(?,%(#,%F{cyan},%F{blue}),%F{red})  >%f '

RPROMPT2='%(?,%F{blue},%F{red})(%B%F{cyan}%_%b%(?,%F{blue},%F{red}))%f'

# Set terminal title to "user@host: pwd"
case $TERM in
    xterm*)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" return 1 }
        ;;
esac

#######################################################################
# aliases
#######################################################################

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

#######################################################################
# path
#######################################################################

path+=~/bin

#######################################################################
# pretty logo & system info
#######################################################################

if [ "$(ps -o comm= $PPID)" != "atom" ] && [ ! -z $DISPLAY ] && command -v screenfetch > /dev/null 2>&1; then
    uname -a | grep ARCH > /dev/null && screenfetch -c 04,15 || screenfetch
fi