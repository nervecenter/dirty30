#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

uint32_t* count_frequencies(uint32_t* array, uint32_t array_len, uint32_t* counts_dict_len) {
    uint32_t highest_num = 0;
    for (int i = 0; i < array_len; i++)
        if (array[i] > highest_num) highest_num = array[i];

    *counts_dict_len = highest_num + 1;
    uint32_t* counts_dict = calloc(*counts_dict_len, sizeof(uint32_t));

    for (int i = 0; i < array_len; i++)
        counts_dict[array[i]] += 1;

    return counts_dict;
}

void ascii_histogram(uint32_t* array, uint32_t array_len) {
    uint32_t    max_bar_length = 30;
    float       max_bar_length_float = (float)max_bar_length;
    uint32_t    counts_dict_len;
    uint32_t*   counts_dict = count_frequencies(array, array_len, &counts_dict_len);
    float       num_buckets_float = (float)array_len;

    uint32_t max_count = 0;
    for (int i = 0; i < counts_dict_len; i++)
        if (counts_dict[i] > max_count)
            max_count = counts_dict[i];
    float max_count_float = (float)max_count;

    uint32_t    count;
    float       count_float;
    float       proportion;
    float       bar_proportion;
    uint32_t    bar_length;
    char*       bar = malloc((sizeof(char) * max_bar_length) + 1);

    for (int i = 0; i < counts_dict_len; i++)
    {
        count = counts_dict[i];
        count_float = (float)count;
        proportion = (count_float / num_buckets_float) * 100.0;
        bar_proportion = count_float / max_count_float;
        bar_length = (uint32_t)floorf(max_bar_length_float * bar_proportion);
        
        memset(bar, '+', bar_length);
        bar[bar_length] = '\0';

        printf("%5d %5d %0.1f%%\t%s\n", i, count, proportion, bar);
    }

    free(counts_dict);
    free(bar);
}

uint8_t rolld6() {
    return rand() % (6 - 1 + 1) + 1;
}

uint8_t dirty30(uint8_t num_dice) {
    uint8_t num_rolls = 0;
    uint8_t sixes;

    while (num_dice > 0) {
        sixes = 0;
        
        for (uint32_t i = 0; i < num_dice; i++)
            if (rolld6() == 6)
                sixes++;

        num_dice -= sixes;
        num_rolls++;
    }
    return num_rolls;
}

int main()
{
    const uint32_t num_games = 100000;
    uint32_t* rolls = calloc(num_games, sizeof(uint32_t));

    for (uint32_t i = 0; i < num_games; i++) {
        rolls[i] = dirty30(30);
    }
    ascii_histogram(rolls, num_games);

    free(rolls);
    return 0;
}
