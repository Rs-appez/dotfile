mkgo(){
    if [[ -z "$1" ]]; then
        echo "Usage: mkgo <dir-name>"
        return 1
    fi

    mkdir -p "$1" && cd "$1" || return 1
}
