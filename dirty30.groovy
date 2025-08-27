import random

from collections import Counter
from statistics import mean, median

def ascii_histogram(rolls, max_bar_length=20) {
    def counts_dict = rolls.countBy()
    def max_count = counts_dict.values().max()
    for k in sorted(counts_dict):
        freq = counts_dict[k]
        val_str = f"{k:5d}"
        freq_str = f"{freq:5d}"
        proportion_str = f"{(counts_dict[k] / len(rolls))*100:0.1f}"
        bar_proportion = freq / max_count
        bar_str = '+'* int(max_bar_length * bar_proportion)
        print(f"{val_str} {freq_str} {proportion_str}%\t{bar_str}")
    print()
}

def mean(arr):
    return sum(arr) / len(arr)

def rolld6():
    return random.randint(1, 6)

def dirty30(num_dice):
    num_rolls = 0
    while num_dice > 0:
        # rolls = [rolld6() for _ in range(num_dice)]
        non_sixes = 0
        for _ in range(num_dice):
            if rolld6() == 6:
                non_sixes += 1
        num_dice -= non_sixes
        num_rolls += 1
        # num_dice -= len([r for r in rolls if r == 6])
    return num_rolls

rolls = [dirty30(30) for _ in range(100000)]
ascii_histogram(rolls, 40)
