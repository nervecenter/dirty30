
function map_of_counts(arr) {
    const result = new Map()
    for (const e of arr) {
        result.set(e, result.has(e) ? result.get(e) + 1 : 1)
    }
    return result
}

function ascii_histogram(rolls, max_bar_length) {
    const counts_dict = map_of_counts(rolls)
    const max_count = counts_dict.values().reduce((a, b) => Math.max(a, b), 0)
    let keys = Array.from(counts_dict.keys())
    keys.sort((a, b) => a - b)

    for (const key of keys) {
        const freq = counts_dict.get(key)
        const proportion = (freq / rolls.length) * 100.0
        const bar_proportion = freq / max_count
        const key_str = `${key}`.padStart(5, ' ')
        const freq_str = `${freq}`.padStart(5, ' ')
        const proportion_str = proportion.toFixed(1)
        const bar_str = '+'.repeat(Math.floor(max_bar_length * bar_proportion))
        console.log(`${key_str} ${freq_str} ${proportion_str}%\t${bar_str}`)
    }
    console.log('')
}

function rolld6() {
    return Math.floor(Math.random() * 6) + 1
}

function dirty30(num_dice) {
    let num_rolls = 0
    let remaining_dice = num_dice
    while (remaining_dice > 0) {
        let sixes = 0
        for (let i = 0; i < remaining_dice; i++) {
            if (rolld6() == 6) {
                sixes += 1
            }
        }
        remaining_dice -= sixes
        num_rolls += 1
    }
    return num_rolls
}

const num_games = 100000
let rolls = new Uint32Array(num_games)
for (let i = 0; i < num_games; i++) {
    rolls[i] = dirty30(30)
}
ascii_histogram(rolls, 40)
