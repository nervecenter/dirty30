
frequencies arr/List -> Map:
    freq_table/Map := {:}
    arr.do: |ele|
        if freq_table.get ele:
            freq_table[ele] += 1
        else:
            freq_table[ele] = 1
    return freq_table

ascii_histogram arr/List max_bar_length/int=30:
    freqs/Map := frequencies arr
    max_count/int := freqs.values.sort.last
    roll_totals/List := freqs.keys.sort
    roll_totals.do: |total|
        freq/int := freqs[total]
        proportion/float := freq.to_float / arr.size.to_float
        bar_len/int := ((freq.to_float / max_count.to_float) * max_bar_length).to_float.ceil.to_int
        bar/string := "+" * bar_len
        print "$(total)\t$(freq)\t$(%0.2f 100.0 * proportion)\t$(bar)"

rolld6 -> int:
    return random 1 7

dirty30 num_dice/int -> int:
    num_rolls/int := 0
    while num_dice > 0:
        sixes/int := 0
        num_dice.repeat:
            if rolld6 == 6:
                sixes += 1
        num_dice -= sixes
        num_rolls += 1
    return num_rolls

main:
    rolls := List 100000: dirty30 30
    ascii_histogram rolls 40
