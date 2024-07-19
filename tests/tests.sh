#!/bin/bash

# Executable
app="../build/a.out"

# Without deadlock with default sleep
$app
if [ $? -eq 0 ]; then
    echo "Test without deadlock and default sleep: PASSED"
else
    echo "Test without deadlock and default sleep: FAILED"
fi

# Deadlock and default sleep
timeout 5s $app --enable-deadlock
if [ $? -eq 124 ]; then
    echo "Test with deadlock (long option) and default sleep: PASSED"
else
    echo "Test with deadlock (long option) and default sleep: FAILED"
fi

# Deadlock (short option) and default sleep
timeout 5s $app -ed
if [ $? -eq 124 ]; then
    echo "Test with deadlock (short option) and default sleep: PASSED"
else
    echo "Test with deadlock (short option) and default sleep: FAILED"
fi

# Unknown option
$app --unknown-option
if [ $? -eq 1 ]; then
    echo "Test with unknown option: PASSED"
else
    echo "Test with unknown option: FAILED"
fi

# Deadlock and custom sleep
timeout 5s $app --enable-deadlock --sleep=200
if [ $? -eq 124 ]; then
    echo "Test with deadlock and custom sleep: PASSED"
else
    echo "Test with deadlock and custom sleep: FAILED"
fi

# Invalid sleep
$app --sleep=abc
if [ $? -eq 1 ]; then
    echo "Test with invalid sleep value: PASSED"
else
    echo "Test with invalid sleep value: FAILED"
fi
