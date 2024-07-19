cmake_minimum_required(VERSION 3.10)

project(DeadlockDemoProject)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(SOURCES
    src/main.cpp
    src/deadlock_demo.cpp
)

set(HEADERS
    include/deadlock_demo.h
)

add_executable(a.out ${SOURCES} ${HEADERS})
