**Project name:** Deadlock demo

**Short description:**
This project presents demonstration of the deadlock problem

**Installing:**
1. Clone project by this command: https://github.com/KirillAnokhin/Deadlock_demo
2. Open the project in your favorite development environment.
3. Build the project using build.sh script.

Possible arguments of a build.sh script:

--clean_build or -cb: Clean the build directory and rebuild the project

--clean or -c: Clean the build directory

--help or -h: Display this help message


**Usage:**
Run the executable file in the build folder with the following commands:

./deadlock_demo <--args>

Available set of args:
--enable-deadlock/-ed=Enable deadlock.

--sleep/sl=Sleep duration in milliseconds (default 100ms)

--debug/-d=Enable debug mode.

--help/-d=Show help message.

To run tests, run the ./run_tests.sh script.

After running the script there will be a prompt for input: (Enter how many seconds to sleep before checking for deadlock:)

After that  vaious tests will be run including deadlocks enabled and disabled.
The strace util was used to detect deadlocks. For detailed information see the script tests/tests.sh
