def ascii_histogram(rolls, max_bar_length = 20) {
    def counts_dict = rolls.countBy().sort()
    def max_count = counts_dict.values().max()
    for (entry in counts_dict) {
        def freq = entry.value
        def proportion = (freq / rolls.size().floatValue()) * 100.0
        def bar_proportion = freq / max_count.floatValue()
        def bar_str = "+" * Math.round(max_bar_length.floatValue() * bar_proportion)
        println "${sprintf('%5d', entry.key)} ${sprintf('%5d', freq)} ${sprintf('%.1f', proportion)}%\t$bar_str"
    }
    println ""
}


def rolld6() {
    return Math.round(Math.random() * 6) + 1
}

def dirty30(num_dice) {
    def num_rolls = 0
    while (num_dice > 0) {
        def non_sixes = 0
        for (_ in 0..num_dice) {
            if (rolld6() == 6) {
                non_sixes += 1
            }
        }
        num_dice -= non_sixes
        num_rolls += 1
    }
    return num_rolls
}

rolls = []
for (_ in 0..100000) {
    rolls.add(dirty30(30))
}
ascii_histogram(rolls, 40)
