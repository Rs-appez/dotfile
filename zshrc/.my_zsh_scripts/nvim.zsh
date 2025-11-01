nt(){
    if [ -z "$1" ]; then
        nvim /tmp/tmp_editor.txt
    elif [[ $1 == -* ]]; then
        nvim /tmp/tmp_editor.txt "$@"
    else
        nvim /tmp/tmp_editor."$1"
    fi
    rm -f /tmp/tmp_editor.*(N)
}

n(){
    if [ -z "$1" ]; then
        nvim .
    elif [[ $1 == -* ]]; then
        nvim . "$@"
    else
        nvim "$1"
    fi
}
