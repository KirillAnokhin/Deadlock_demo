#include "../include/deadlock_demo.h"
#include <iostream>
#include <thread>
#include <chrono>

DeadlockDemo::DeadlockDemo(const Options& parsed_opts)
    : parsed_opts_(parsed_opts) {}

void DeadlockDemo::run() {
    std::thread t1(&DeadlockDemo::task1, this);
    std::thread t2(&DeadlockDemo::task2, this);

    t1.join();
    t2.join();
    if (parsed_opts_.enable_debug_) {
        std::cout << "Main thread completed\n";
    }
}

void DeadlockDemo::lock_mutexes(std::mutex& first, std::mutex& second) {
    if (parsed_opts_.enable_deadlock_) {
        std::lock_guard<std::mutex> lock1(first);
        // Immitation of work
        std::this_thread::sleep_for(std::chrono::milliseconds(parsed_opts_.sleep_duration_ms_));
        std::lock_guard<std::mutex> lock2(second);
    } else {
        std::lock(first, second);
        std::lock_guard<std::mutex> lock1(first, std::adopt_lock);
        std::lock_guard<std::mutex> lock2(second, std::adopt_lock);
    }
}

void DeadlockDemo::task1() {
    lock_mutexes(mutex1, mutex2);
    if (parsed_opts_.enable_debug_) {
        std::cout << "Task 1 completed\n";
    }
}

void DeadlockDemo::task2() {
    lock_mutexes(mutex2, mutex1);
    if (parsed_opts_.enable_debug_) {
        std::cout << "Task 2 completed\n";
    }
}