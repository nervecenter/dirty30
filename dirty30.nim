import random
import sequtils
import tables
import sugar
import strformat
import strutils
import sequtils
import algorithm

randomize()

proc ascii_histogram(rolls: seq[int], max_bar_length=20) =
    let
        counts_table = rolls.toCountTable
        largest = float(counts_table.largest.val)
        num_rolls_float = float(rolls.len)
        max_bar_length_float = float(max_bar_length)
        roll_values = counts_table.keys.toSeq.sorted

    for k in roll_values:
        let
            freq = counts_table[k]
            freq_float = float(freq)
            proportion = (freq_float / num_rolls_float) * 100.0
            bar_proportion = freq_float / largest
            bar_str = repeat('+', int(max_bar_length_float * bar_proportion))
        echo &"{k:5d} {freq:5d} {proportion:0.1f}% \t{bar_str}"

proc dirty30_imperative(num_dice: int): int =
    var
        num_rolls = 0
        num_dice_remaining = num_dice

    while num_dice_remaining > 0:
        var non_sixes = 0
        for _ in 0..num_dice_remaining:
            if rand(1..6) == 6:
                non_sixes += 1
        num_dice_remaining -= non_sixes
        num_rolls += 1

    return num_rolls

proc rolld6(): int =
    return rand(1..6)

proc rollnd6(n: int): seq[int] =
    return collect(newSeq):
        for _ in 0..<n: rolld6()

proc dirty30_rec(num_dice: int, num_rolls: int): int =
    if num_dice == 0:
        return num_rolls
    else:
        let new_num_dice = rollnd6(num_dice).filter(r => r < 6).len
        return dirty30_rec(new_num_dice, num_rolls + 1)

proc dirty30_recursive(num_dice: int): int =
    dirty30_rec(num_dice, 0)

let rolls = collect(newSeq):
    for _ in 0..100000: dirty30_imperative(30)

ascii_histogram(rolls, 40)
