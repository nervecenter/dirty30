
var map_of_counts = Fn.new {|arr|
    var result = {}
    for (e in arr) {
        if (result.containsKey(e)) {
            result[e] += 1
        } else {
            result[e] = 1
        }
    }
    return result
}

var ascii_histogram = Fn.new {|rolls, max_bar_length|
    var counts_dict = map_of_counts(rolls)
    var max_count = counts_dict.values.reduce {|a, b| => a.max(b)}
    var keys = Array.from(counts_dict.keys())
    keys.sort((a, b) => a - b)

    for (key in keys) {
        var freq = counts_dict.get(key)
        var proportion = (freq / rolls.length) * 100.0
        var bar_proportion = freq / max_count
        var key_str = "$(key)".padStart(5, ' ')
        var freq_str = "$(freq)".padStart(5, ' ')
        var proportion_str = proportion.toFixed(1)
        var bar_str = "+" * (max_bar_length * bar_proportion).floor
        System.print("$(key_str) $(freq_str) $(proportion_str)%\t$(bar_str)")
    }
    System.print('')
}

var rolld6() {
    return Math.floor(Math.random() * 6) + 1
}

var dirty30(num_dice) {
    var num_rolls = 0
    var remaining_dice = num_dice
    while (remaining_dice > 0) {
        var sixes = 0
        for (var i = 0; i < remaining_dice; i++) {
            if (rolld6() == 6) {
                sixes += 1
            }
        }
        remaining_dice -= sixes
        num_rolls += 1
    }
    return num_rolls
}

var num_games = 100000
var rolls = new Uint32Array(num_games)
for (var i = 0; i < num_games; i++) {
    rolls[i] = dirty30(30)
}
ascii_histogram(rolls, 40)
