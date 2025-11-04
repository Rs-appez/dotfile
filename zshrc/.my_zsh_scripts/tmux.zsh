tn(){
    if [ -z "$1" ]; then
        name=$(basename "$PWD")
        if [[ "${name:0:1}" == "." ]]; then
            name=${name:1}
        fi
        SESSION_NAME=$name
        echo "$SESSION_NAME"

    else
        SESSION_NAME="$1"
    fi

    tmux new -d -s "$SESSION_NAME" 

    tmux new-window -t "$SESSION_NAME":2 -n "nvim"
    tmux new-window -t "$SESSION_NAME":3 -n "git"
    tmux new-window -t "$SESSION_NAME":4 -n "server"

    tmux select-window -t "$SESSION_NAME":1
    tmux attach -t "$SESSION_NAME"

}
