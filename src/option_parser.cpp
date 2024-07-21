#include "../include/option_parser.h"

OptionParser::OptionParser(const std::string& config_name)
    : options_config_name_(config_name) {}

void OptionParser::print_help() {
    std::cout << "Available options:\n";
    for (const auto& [key, value] : available_options_) {
        std::cout << key << ": " << value << "\n";
    }
}

bool OptionParser::parse_available_options() {
     std::ifstream config_file(options_config_name_);
    if (!config_file.is_open()) {
        std::cerr << "Failed to open options.txt file." << "\n";
        return false;
    }

    std::string line;
    while (std::getline(config_file, line)) {
        std::istringstream iss(line);
        std::string key, value;
        if (std::getline(iss, key, '=') && std::getline(iss, value)) {
            available_options_[key] = value;
        }
    }

    config_file.close();
    return true;
}

// Check if a key contains a substring of the dictionary keys
bool contains_substring(const std::string& key, const std::unordered_map<std::string, std::string>& opts) {
  for (const auto& [opt_key, opt_value] : opts) {
    if (key.find(opt_key) != std::string::npos) {
      return true;
    }
  }
  return false;
}

bool OptionParser::parse_arguments(int argc, char* argv[]) {
    if (!parse_available_options()) {
        return false;
    }

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];

        auto check_option_exists = [](const std::unordered_map<std::string, std::string>& opts, const std::string& key) {
            return contains_substring(key, opts);
        };

        if (!check_option_exists(available_options_, arg)) {
            std::cerr << "Undefined option: " << arg << "\n";
            print_help();
            return false;
        }

        if (arg == "--enable-deadlock" || arg == "-ed") {
            parsed_opts_.enable_deadlock_ = true;
        }
        if (arg.rfind("--sleep=", 0) == 0) {
            try {
                parsed_opts_.sleep_duration_ms_ = std::stoi(arg.substr(8));
            } catch (const std::invalid_argument&) {
                std::cerr << "Invalid value for --sleep\n";
                return false;
            } catch (const std::out_of_range&) {
                std::cerr << "Value for --sleep is out of range\n";
                return false;
            }
        }
        if (arg == "--debug" || arg == "-d") {
            parsed_opts_.enable_debug_ = true;
        }
        if (arg == "--help" || arg == "-h") {
            print_help();
        }
    }
    return true;
}