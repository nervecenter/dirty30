#include <cstdio>
#include <vector>
#include <map>
// #include <ranges>
#include <string>
#include <algorithm>
#include <cstdint>
#include <format>
#include <cstdlib>

template <typename T>
std::map<T, uint32_t> count_frequencies(std::vector<T> array) {
    std::map<T, uint32_t> freqDict;

    for (const T& ele : array) {
        freqDict[ele] += 1;
    }

    return freqDict;
}

void ascii_histogram(std::vector<uint32_t> array, uint32_t max_bar_length = 30)
{
    auto counts_dict = count_frequencies<uint32_t>(array);
    auto max_count_iterator = std::max_element(
        counts_dict.begin(), counts_dict.end(),
        [](const std::pair<uint32_t, uint32_t>& p1, const std::pair<uint32_t, uint32_t>& p2) {
            return p1.second < p2.second;
        }
    );
    auto max_count = (*max_count_iterator).second;
    float max_bar_length_float = static_cast<float>(max_bar_length);
    float max_count_float = static_cast<float>(max_count);

    for (auto& [key, freq] : counts_dict)
    {
        float freq_float = static_cast<float>(freq);
        float proportion = (freq_float / static_cast<float>(array.size())) * 100.0;

        float bar_proportion = freq_float / max_count_float;
        int bar_length = static_cast<uint32_t>(max_bar_length_float * bar_proportion);
        std::string bar = std::string(bar_length, '+');

        printf("%5d %5d %0.1f%%\t%s\n", key, freq, proportion, bar.c_str());
    }
}

uint8_t rolld6() {
    return rand() % (6 - 1 + 1) + 1;
}

uint8_t dirty30(uint8_t num_dice) {
    uint8_t num_rolls = 0;
    while (num_dice > 0) {
        uint8_t non_sixes = 0;
        
        for (uint32_t i = 0; i < num_dice; i++) {
            if (rolld6() == 6) { non_sixes++; }
        }

        num_dice -= non_sixes;
        num_rolls++;
    }
    return num_rolls;
}

int main()
{
    std::vector<uint32_t> rolls = {};

    for (uint32_t i = 0; i < 100000; i++) {
        rolls.push_back(dirty30(30));
    }
    ascii_histogram(rolls);

    return 0;
}
