#include <iostream>
#include <string>
#include <stdexcept>
#include "../include/deadlock_demo.h"

void print_help(char* argv[]) {
    std::cout << "Usage: " << argv[0] << " [options]\n";
    std::cout << "Options:\n";
    std::cout << "  --enable-deadlock, -ed: Enable deadlock demo.\n";
    std::cout << "  --sleep, -s <ms>: Sleep duration in milliseconds (default: 100).\n";
    std::cout << "  --debug, -d: Enable debug mode.\n";
    std::cout << "  --help, -h: Show this help message.\n";
}

bool parse_arguments(int argc, char* argv[], bool& enable_deadlock, bool& enable_debug, int& sleep_duration_ms) {
    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "--enable-deadlock" || arg == "-ed") {
            enable_deadlock = true;
        } else if (arg.rfind("--sleep=", 0) == 0) {
            try {
                sleep_duration_ms = std::stoi(arg.substr(8));
            } catch (const std::invalid_argument&) {
                std::cerr << "Invalid value for --sleep\n";
                return false;
            } catch (const std::out_of_range&) {
                std::cerr << "Value for --sleep is out of range\n";
                return false;
            }
        } else if (arg == "--debug" || arg == "-d") {
            // Enable debug mode.
        } else if (arg == "--help" || arg == "-h") {
            print_help(argv);
            return false;
        } else {
            std::cerr << "Unknown option: " << arg << std::endl;
            print_help(argv);
            return false;
        }
    }
    return true;
}

int main(int argc, char* argv[]) {
    // Defaule values
    bool enable_deadlock = false;
    bool enable_debug    = false;
    int sleep_duration_ms = 100;
    // Parse command line args
    if (!parse_arguments(argc, argv, enable_deadlock, enable_debug, sleep_duration_ms)) {
        return 1;
    }

    DeadlockDemo demo(enable_deadlock, enable_debug, sleep_duration_ms);
    demo.run();

    return 0;
}
