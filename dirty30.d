import
    std.stdio,
    std.conv,
    std.random,
    std.range,
    std.format,
    std.algorithm.sorting,
    std.algorithm.iteration,
    std.algorithm.searching;

import std.range : repeat;

int[T] countFrequencies(T)(T[] array)
{
    int[T] freqDict;
    foreach (T ele; array)
    {
        freqDict.update(
            ele,
            { return 1; },
            (ref int c) { c++; }
        );
    }
    return freqDict;
}

void ascii_histogram(int[] array, int max_bar_length = 30)
{
    int[int] counts_dict = countFrequencies!int(array);
    int max_count = maxElement(counts_dict.values);
    float max_bar_length_float = to!float(max_bar_length);
    float max_count_float = to!float(max_count);

    int[] count_dict_keys = counts_dict.keys;
    count_dict_keys.sort();

    foreach (int key; count_dict_keys)
    {
        int freq = counts_dict[key];
        float freq_float = to!float(freq);
        float proportion = (freq_float / to!float(array.length)) * 100.0;
        float bar_proportion = freq_float / max_count_float;
        int bar_length = to!int(max_bar_length_float * bar_proportion);

        writeln(format(
            "%5d %5d %0.1f%%\t%s",
            key, freq, proportion, to!string('+'.repeat(bar_length))
        ));
    }
}

auto rolld6 = () => uniform!"[]"(1, 6);

int dirty30(int num_dice)
{
    int num_rolls = 0;
    while (num_dice > 0)
    {
        int sixes = 0;
        
        foreach (int i; 0..num_dice)
            if (rolld6() == 6) sixes++;

        num_dice -= sixes;
        num_rolls++;
    }
    return num_rolls;
}

void main()
{
    int num_games = 100000;
    int[] rolls = [];
    rolls.reserve(num_games);
    foreach (i; 0..num_games)
        rolls ~= dirty30(30);

    ascii_histogram(rolls);
}
