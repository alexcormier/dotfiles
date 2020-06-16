export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export CLICOLOR=1
export LSCOLORS=exFxCxDxBxegedabagacad

if command -v bat > /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

command -v vim > /dev/null 2>&1 && export EDITOR='vim'

case "$(uname -s)" in
    Linux)
        export CC="gcc"
        export CXX="g++"
        ;;
    Darwin)
        export CC="clang"
        export CXX="clang++"
        export STUDIO_JDK="$(/usr/libexec/java_home)/../.."
	$(boot2docker shellinit 2> /dev/null)
        ;;
esac

for file in $HOME/bin/**/*; do
    if [ -d $file ]; then
        path=("$file" $path)
    fi
done
path=("$HOME/bin" "$HOME/.local/bin" $path)

mkdir -p $HOME/.zfunc
fpath+=$HOME/.zfunc

if command -v go > /dev/null 2>&1; then
    export GOPATH="$HOME/git/go"
    path=("$GOPATH/bin" $path)
    path+="$(go env GOROOT)/bin"
fi

[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

