export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export CLICOLOR=1
export LSCOLORS=exFxCxDxBxegedabagacad

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
# command -v rustc > /dev/null 2>&1 && export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src

if [[ -d ~/omnetpp-4.6 ]]; then
    pushd ~/omnetpp-4.6 > /dev/null
    source ./setenv > /dev/null
    popd > /dev/null
fi

if [ -f $HOME/.local/bin/virtualenvwrapper_lazy.sh ]; then
    export WORKON_HOME=$HOME/.venvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2
    source $HOME/.local/bin/virtualenvwrapper_lazy.sh
fi

