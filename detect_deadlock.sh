#!/bin/bash

app="build/deadlock_demo"

flags="-ed"

# Get PID
pid=$(pgrep -f "$app $flags")

# Run app
if [ -z "$pid" ]; then
    echo "App $APP_NAME is not running."
    $APP_NAME $APP_FLAGS &
    pid=$!
fi

# Run strace to detect app's system calls 
strace -p "$pid" -f -e trace=futex,wait4,nanosleep,ppoll,pselect6,select,poll -o strace_output.txt
