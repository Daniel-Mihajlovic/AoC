#include <fstream>
#include <iostream>
#include <vector>
#include <algorithm>
#include <sstream>
#include <ranges>
#include <cstdint>

bool isSafe(std::vector<uint32_t> levels) {
    for (int i{}; std::tuple t : levels | std::views::adjacent<3>)
    {   
        auto [prev, curr, next] = t;
        int32_t d1 = prev-curr;
        int32_t d2 = curr-next;
        if (d1*d2 < 0) return false;
        if (abs(d1) < 1 || abs(d1) > 3) return false;
        if (abs(d2) < 1 || abs(d2) > 3) return false;
    }

    return true;
}

int solve() {
    std::ifstream istream{"input.txt"};
    if (!istream) {
        std::cerr << "Failed to open file";
    }

    uint32_t l;
    uint32_t safe1 = 0;
    uint32_t safe2 = 0;
    std::vector<uint32_t> level{};
    while (istream >> l) {
        level.push_back(l);
        if (istream.peek() == '\n') {
            if (isSafe(level)) {
                safe1++;   
                safe2++;
            } else {
                for (int i = 0; i < level.size(); i++) {
                    std::vector<uint32_t> alternative; 
                    std::copy(level.begin(), level.end(), std::back_inserter(alternative));
                    alternative.erase(alternative.begin() + i);
                    if (isSafe(alternative)) {
                        safe2++;
                        break;
                    }
                }
            }
            level.clear();
        }
    }

    std::cout << "part1: " << safe1 << '\n';
    std::cout << "part2: " << safe2 << '\n';
    return 0;
}

int main()
{
    return solve();
}