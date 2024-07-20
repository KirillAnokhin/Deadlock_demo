#pragma once

#include <mutex>
#include "options.h"

class DeadlockDemo {
 public:
    DeadlockDemo(const Options& parsed_opts);
    void run();

 private:
    std::mutex mutex1;
    std::mutex mutex2;
    Options parsed_opts_;

    void lock_mutexes(std::mutex& first, std::mutex& second);
    void task1();
    void task2();
};
