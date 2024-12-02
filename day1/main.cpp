#include <fstream>
#include <iostream>
#include <vector>
#include <algorithm>
#include <ranges>
#include <cstdint>

int solve() {
    std::ifstream istream{"input.txt"};
    if (!istream) {
        std::cerr << "Failed to open file";
    }

    std::vector<u_int32_t> l1{};
    std::vector<u_int32_t> l2{};
    
    uint32_t l, r;
    while (istream >> l >> r) {
        l1.push_back(l);
        l2.push_back(r);
    }

    std::ranges::sort(l1);
    std::ranges::sort(l2);

    auto sum = 0;
    int v;
    for(size_t i = 0; i < l1.size(); i++) {
        sum += abs(l1.at(i) - l2.at(i));
    }

    std::cout << sum << '\n';
    return 0;
}

int main()
{
    return solve();
}