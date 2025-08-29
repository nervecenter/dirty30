import random

from collections import Counter

def ascii_histogram(rolls, max_bar_length=20):
    counts_dict = Counter(rolls)
    max_count = max(counts_dict.values())
    for k in sorted(counts_dict):
        freq = counts_dict[k]
        proportion = (counts_dict[k] / len(rolls)) * 100.0
        bar_proportion = freq / max_count
        bar_str = '+'* int(max_bar_length * bar_proportion)
        print(f"{k:5d} {freq:5d} {proportion:0.1f}%\t{bar_str}")
    print()

def rolld6():
    return random.randint(1, 6)

def dirty30(num_dice):
    num_rolls = 0
    while num_dice > 0:
        sixes = 0
        for _ in range(num_dice):
            if rolld6() == 6:
                sixes += 1
        num_dice -= sixes
        num_rolls += 1
    return num_rolls

rolls = [dirty30(30) for _ in range(100000)]
ascii_histogram(rolls, 40)
