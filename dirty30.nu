def ascii_histogram [] {
    let hist = $in | histogram | sort-by value
    echo $hist
}

def dirty30 [num_dice: int, num_rolls: int = 0] {
    mut num_dice = $num_dice
    mut num_rolls = $num_rolls
    while $num_dice > 0 {
        $num_dice = random dice --dice $num_dice --sides 6 | where $it < 6 | length
        $num_rolls += 1
    }
    return $num_rolls
}

1..100000 | each { |i| dirty30 30 } | ascii_histogram

