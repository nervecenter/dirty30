use fastrand;
use itertools::Itertools;

fn ascii_histogram(a_vector: Vec<i32>, max_bar_length: i32) {
    let freqs = a_vector.iter().counts();
    let max_count = *freqs.values().max().unwrap();

    for val in freqs.keys().sorted() {
        let freq = freqs[val];
        let proportion = 100.0 * (freq as f32 / a_vector.len() as f32);
        let bar_str =
            "+".repeat((max_bar_length as f32 * (freq as f32 / max_count as f32)) as usize);
        println!("{val:3}\t{freq:5}\t{proportion:.1}\t{bar_str}");
    }
}

fn rolld6() -> i32 {
    fastrand::i32(1..7)
}

fn rollnd6(n: i32) -> Vec<i32> {
    (0..n).map(|_| rolld6()).collect::<Vec<i32>>()
}

fn dirty30_rec(num_dice: i32, num_rolls: i32) -> i32 {
    if num_dice == 0 {
        num_rolls
    } else {
        let new_num_dice = rollnd6(num_dice)
            .into_iter()
            .filter(|&r| r < 6)
            .collect::<Vec<i32>>()
            .len()
            .try_into()
            .unwrap();
        dirty30_rec(new_num_dice, num_rolls + 1)
    }
}

fn dirty30(num_dice: i32) -> i32 {
    dirty30_rec(num_dice, 0)
}

fn main() {
    ascii_histogram((0..100000).map(|_| dirty30(30)).collect::<Vec<i32>>(), 40)
}
