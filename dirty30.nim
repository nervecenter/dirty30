import random
import tables
import sugar
import strformat
import sequtils
import strutils
import algorithm

randomize()

proc ascii_histogram(rolls: seq[int], max_bar_length: int = 20) =
    let
        counts_table = rolls.to_count_table()
        num_rolls_float = float(rolls.len)
        max_count = counts_table.largest.val
        max_count_float = float(max_count)
        max_bar_length_float = float(max_bar_length)
        roll_values_sorted = counts_table.keys.to_seq().sorted()

    for key in roll_values_sorted:
        let
            freq = counts_table[key]
            freq_float = float(freq)
            proportion = (freq_float / num_rolls_float) * 100.0
            bar_proportion = freq_float / max_count_float
            bar_length = int(max_bar_length_float * bar_proportion)
            bar_str = repeat('+', bar_length)
        echo &"{key:5d} {freq:5d} {proportion:.1f}%\t{bar_str}"

    echo ""

proc dirty30(num_dice: int): int =
    var num_rolls = 0
    var remaining_dice = num_dice

    while remaining_dice > 0:
        var sixes = 0
        for _ in 0 ..< remaining_dice:
            if rand(1 .. 6) == 6:
                sixes += 1
        remaining_dice -= sixes
        num_rolls += 1

    return num_rolls

let num_games = 100000
let rolls = collect(new_seq_of_cap(num_games)):
    for _ in 0 .. num_games:
        dirty30(30)

ascii_histogram(rolls, 40)
