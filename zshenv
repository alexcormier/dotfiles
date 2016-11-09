export CLICOLOR=1
export LSCOLORS=exFxCxDxBxegedabagacad

command -v vim > /dev/null 2>&1 && export EDITOR='vim'

case "$(uname -s)" in
    Linux)
        export C="gcc"
        export CXX="g++"
        ;;
    Darwin)
        export C="clang"
        export CXX="clang++"
        export STUDIO_JDK="$(/usr/libexec/java_home)/../.."
	$(boot2docker shellinit 2> /dev/null)
        ;;
esac

path=("$HOME/bin" $path)

if command -v go > /dev/null 2>&1; then
    export GOPATH="$HOME/git/go"
    path=("$GOPATH/bin" $path)
    path+="$(go env GOROOT)/bin"
fi
