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

It is also possible to run a set of tests by running a ./run_tests.sh script
