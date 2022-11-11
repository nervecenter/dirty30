# dirty30

A fantasy gambling game implemented in numerous novel languages. Compare performance between. Includes a number of common data manipulation tasks:

- Run a procedure a large number times
- Generate die rolls a dynamic number of times
- Collect results into a sequence
- Generate a hash map histogram of that sequence
- Format and print the histogram

The rules of Dirty 30: The player starts the first round by rolling 30 dice. Any 6's are removed for the next round, wherein the remaining dice are rolled. The goal is to roll enough 6's to remove all the dice in the pool on or before the 30th roll. There are any number of gambling opportunities, such as betting on the number of rolls it will take to win, with larger payouts the earlier a correct prediction is made.

This program runs 100,000 Dirty 30 games, and records how many rolls it took to consume all 30 dice, then prints out a histogram of the games' results.

## Clojure

```bash
time clojure dirty30.clj
```

## Common Lisp

```bash
time sbcl --script dirty30.lisp
```

## D

```bash
dmd dirty30.d
time ./dirty30
```

# Janet

```bash
time janet dirty30.janet
```

# Nim

```bash
nim c dirty30.nim
time ./dirty30
```

# Python

```bash
time python dirty30.py
```

# Racket

```bash
time racket dirty30.rkt
```

# Rust

```bash
cd dirty30-rs
cargo build --release
time ./target/release/dirty30-rs
```
