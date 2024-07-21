#!/bin/bash

cd ..

# Executable
app="build/deadlock_demo"
timeout_duration=5

# Without deadlock with default sleep
echo "Test without deadlock and default sleep: "
$app
if [ $? -eq 0 ]; then
    echo "PASSED"
else
    echo "FAILED"
fi
echo -e "\n"

# Deadlock and default sleep
echo "Test with deadlock (long option) and default sleep:"
timeout $timeout_duration $app --enable-deadlock
if [ $? -eq 124 ]; then
    echo "PASSED"
else
    echo "FAILED"
fi
echo -e "\n"

# Deadlock (short option) and default sleep
echo "Test with deadlock (short option) and default sleep:"
timeout $timeout_duration $app -ed
if [ $? -eq 124 ]; then
    echo "PASSED"
else
    echo "FAILED"
fi
echo -e "\n"

# Unknown option
echo "Test with unknown option"
$app --unknown-option
if [ $? -eq 1 ]; then
    echo "PASSED"
else
    echo "FAILED"
fi
echo -e "\n"

echo "Test with deadlock and custom sleep:"
# Deadlock and custom sleep
timeout $timeout_duration $app --enable-deadlock --sleep=200
if [ $? -eq 124 ]; then
    echo "PASSED"
else
    echo "FAILED"
fi
echo -e "\n"

# Invalid sleep
echo "Test with invalid sleep value:"
$app --sleep=abc
if [ $? -eq 1 ]; then
    echo "PASSED"
else
    echo "FAILED"
fi
echo -e "\n"
