#include "../include/deadlock_demo.h"
#include "../include/option_parser.h"
#include "../include/options.h"

int main(int argc, char* argv[]) {
    OptionParser parser("options.txt");

    // Parse command line args
    if (!parser.parse_arguments(argc, argv)) {
        return 1;
    }

    DeadlockDemo demo(parser.get_parsed_options());
    demo.run();

    return 0;
}
