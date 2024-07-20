cmake_minimum_required(VERSION 3.10)

project(DeadlockDemoProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(SOURCES
    src/main.cpp
    src/deadlock_demo.cpp
    src/option_parser.cpp
)

set(HEADERS
    include/deadlock_demo.h
    include/option_parser.h
    include/options.h
)

add_executable(deadlock_demo ${SOURCES} ${HEADERS})
