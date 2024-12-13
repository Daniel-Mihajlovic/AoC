#include <string>
#include <iostream>
#include <fstream>
#include <regex>

int solve() {
    std::ifstream istream{"input"};
    if (!istream) {
        std::cerr << "Failed to open file";
    }

    std::string s;
    std::string input;
    while (istream >> s) {
        input += s;
    }

    bool first, mul = true;
    int v1, v2, res = 0;
    std::regex command("mul\\([0-9]+\\,[0-9]+\\)|do\\(\\)|don\\'t\\(\\)");
    std::regex integer("[0-9]+");
    for(std::smatch sm; std::regex_search(input, sm, command);) {
        auto match = sm.str();
        if (match == "don't()")
            mul = false;
        if (match == "do()")
             mul = true;

        if (mul) {
            for(std::smatch im; std::regex_search(match, im, integer);) {
                if (first) {
                    v1 = stoi(im.str());
                    first = false;
                } else {
                    v2 = stoi(im.str());
                }
                match = im.suffix();
            }
            res += v1 * v2;
        }

        v1, v2 = 0;
        first = true;
        input = sm.suffix();
    }
    
    std::cout << res << '\n';

    return 0;
}

int main()
{
    return solve();
}