#!/bin/bash

cd ..

echo -n "Enter how many seconds to sleep before checking for deadlock: "
read -r timeout_duration
echo -e "\n"

# Executable
app="build/deadlock_demo"

check_deadlock() {
    local cmd="$1"
    local strace_output="strace_output.txt"

    # Run command
    eval "$cmd"
    local APP_PID=$!

    # Wait for potential deadlock
    echo "Sleep for $timeout_duration seconds"
    sleep $timeout_duration

    # Check if process is still running
    if ps -p $APP_PID > /dev/null; then
        echo "The application is still running. Checking for deadlocks..."

        # Grep for futex...unfinished
        if grep -qE "futex.*unfinished|unfinished.*futex" "$strace_output"; then
            echo "Potential deadlock detected!"
            kill -9 $APP_PID
            return 0
        else
            echo "No deadlock detected."
            kill -9 $APP_PID
            return 1
        fi
    else
        echo "The application has terminated."
        return 1
    fi
}

# Without deadlock with default sleep
echo "Test without deadlock and default sleep: "
command="strace -f -o strace_output.txt $app &"
if check_deadlock "$command"; then
    echo "FAILED. Deadlock detected."
else
    echo "PASSED. No deadlock detected."
fi
echo -e "\n"

# Deadlock with default sleep
echo "Test with deadlock (long option) and default sleep: "
command="strace -f -o strace_output.txt $app --enable-deadlock &"
if check_deadlock "$command"; then
    echo "FAILED. Deadlock detected."
else
    echo "PASSED. No deadlock detected."
fi
echo -e "\n"

# Deadlock (short option) and default sleep
echo "Test with deadlock (short option) and default sleep:"
command="strace -f -o strace_output.txt $app -ed &"
if check_deadlock "$command"; then
    echo "FAILED. Deadlock detected."
else
    echo "PASSED. No deadlock detected."
fi
echo -e "\n"

# Unknown option
echo "Test with unknown option"
$app --unknown-option
if [ $? -eq 1 ]; then
    echo "FAILED. Unknown option"
else
    echo "PASSED"
fi
echo -e "\n"

# Deadlock with custom sleep 2s
echo "Test with deadlock and custom sleep 2 sec:"
command="strace -f -o strace_output.txt $app -ed --sleep=2000 &"
if check_deadlock "$command"; then
    echo "FAILED. Deadlock detected."
else
    echo "PASSED. No deadlock detected."
fi
echo -e "\n"

# Invalid sleep value
echo "Test with invalid sleep value:"
$app --sleep=abc
if [ $? -eq 1 ]; then
    echo "FAILED. Invalid sleep value"
else
    echo "PASSED"
fi
echo -e "\n"
