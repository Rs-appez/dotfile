alias ping=fun_ping

fun_ping(){
    args="$*"
    if [[ -z "$args" ]]; then
        echo "Ping or Pong?\nTennis de table!"
        return 0
    fi
    \ping $args
}
