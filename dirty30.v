import rand
import arrays
import strings

fn ascii_histogram(rolls []int, max_bar_length int)! {
    counts_dict := arrays.map_of_counts(rolls)
    max_count := arrays.max(counts_dict.values())!
    for key in counts_dict.keys().sorted() {
        freq := counts_dict[key]
        proportion := (freq / f64(rolls.len)) * 100.0
        bar_proportion := freq / f64(max_count)
        bar_str := strings.repeat('+'.bytes()[0], int(f64(max_bar_length) * bar_proportion))
        println('${key:5d} ${freq:5d} ${proportion:.1f}%\t${bar_str}')
    }
    println('')
}


fn rolld6() int {
    return rand.int() % 6 + 1
}

fn dirty30(num_dice int) int {
    mut num_rolls := 0
    mut this_num_dice := num_dice
    for this_num_dice > 0 {
        mut non_sixes := 0
        for _ in 0 .. this_num_dice {
            if rolld6() == 6 {
                non_sixes += 1
            }
        }
        this_num_dice -= non_sixes
        num_rolls += 1
    }
    return num_rolls
}

fn main() {
    num_games := 100000
    mut rolls := []int{cap: num_games}
    for _ in 0 .. num_games {
        rolls << dirty30(30)
    }
    ascii_histogram(rolls, 40)!
}
