#pragma once

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <stdexcept>
#include <unordered_map>
#include "options.h"

class OptionParser {
 public:
    OptionParser(const std::string& config_name);
    bool parse_arguments(int argc, char* argv[]);
    Options get_parsed_options() { return parsed_opts_; }

 private:
    bool parse_available_options();
    void print_help();

    using options_map = std::unordered_map<std::string, std::string>;
    options_map available_options_;
    std::string options_config_name_;

    Options parsed_opts_;
};