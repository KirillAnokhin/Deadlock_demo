#!/bin/bash

if [ $# -eq 0 ]; then
    mkdir build
    cd build
    cmake ..
    make
else
    while [[ $# -gt 0 ]]
    do
        key="$1"

        case $key in
            --clean_build|-cb)
            rm -rf build
            mkdir build
            cd build
            cmake ..
            make
            shift
            ;;
            --clean|-c)
            rm -rf build
            shift
            ;;
            --help|-h)
            echo "Possible arguments:"
            echo "--clean_build or -cb: Clean the build directory and rebuild the project"
            echo "--clean or -c: Clean the build directory"
            echo "--help or -h: Display this help message"
            shift
            ;;
            *)
            echo "Unknown option: $1"
            exit 1
            ;;
        esac
    done
fi
