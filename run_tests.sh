#!/bin/bash

# Check if build folder exists
if [ -d "build" ]; then
    echo -e "Directory 'build' exists"
    # Check if there is executable in build folder
    if [ -f "build/deadlock_demo" ]; then
        echo -e "Executable file 'deadlock_demo' exists in 'build' directory.\nRunning tests... \n"
        cd tests
        chmod +x tests.sh
        ./tests.sh
    else
        echo "File 'a.out' does not exist in 'build' directory, run build.sh first"
    fi
else
    echo "Directory 'build' does not exist, run build.sh script first"
fi
