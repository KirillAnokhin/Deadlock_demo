#!/bin/bash

# Check if build folder exists
if [ -d "build" ]; then
    echo -e "Directory 'build' exists\n"
    # Check if there is executable in build folder
    if [ -f "build/a.out" ]; then
        echo -e "File 'a.out' exists in 'build' directory.\nRunning tests... \n"
        cd tests
        chmod +x tests.sh
        ./tests.sh
    else
        echo "File 'a.out' does not exist in 'build' directory, run build.sh first"
    fi
else
    echo "Directory 'build' does not exist, run build.sh script first"
fi
