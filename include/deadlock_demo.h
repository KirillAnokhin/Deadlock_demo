#pragma once

#include <mutex>

class DeadlockDemo {
public:
    DeadlockDemo(bool enable_deadlock, bool enable_debug, int sleep_duration_ms);
    void run();

private:
    std::mutex mutex1;
    std::mutex mutex2;
    bool enable_deadlock_;
    bool enable_debug_;
    int sleep_duration_ms_;

    void lock_mutexes(std::mutex& first, std::mutex& second);
    void task1();
    void task2();
};
