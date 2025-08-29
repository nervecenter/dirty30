# dirty30

A fantasy gambling game implemented in numerous novel languages. Performs a Monte Carlo simulation of 100,000 games. Prints a histogram of the results. Can use `time` to compare performance between. Includes a number of common data manipulation tasks:

- Run a procedure a large number times
- Generate die rolls a dynamic number of times
- Collect results into a sequence
- Generate a hash map histogram of that sequence
- Format and print the histogram

For languages which favor an imperative/procedural approach, iteration is used where it can maximize performance. Otherwise, a functional/data-oriented approach is used.

The rules of Dirty 30: The player starts the first round by rolling 30 dice. Any 6's are removed for the next round, wherein the remaining dice are rolled. The goal is to roll enough 6's to remove all the dice in the pool on or before the 30th roll. There are any number of gambling opportunities, such as betting on the number of rolls it will take to win, with larger payouts the earlier a correct prediction is made.

#### C++

```bash
g++ -std=c++20 dirty30.cpp -o dirty30
time ./dirty30
```

#### Clojure

```bash
time clojure dirty30.clj
```

#### Common Lisp

```bash
time sbcl --script dirty30.lisp
```

#### D

```bash
dmd -O -release dirty30.d
time ./dirty30
```

#### Groovy

```bash
time groovy dirty30.groovy
```

#### Io

```bash
time io dirty30.io
```

#### Janet

```bash
time janet dirty30.janet
```

#### JavaScript

```bash
time node dirty30.js
```

#### Nim

```bash
nim cc -d:release dirty30.nim
time ./dirty30
```

#### Nushell

```bash
time nu dirty30.nu
```

#### Python

```bash
time python3 dirty30.py
```

#### Racket

```bash
time racket dirty30.rkt
```

#### Rust

```bash
cd dirty30-rs
cargo build --release
time ./target/release/dirty30-rs
```

#### V

```bash
v -prod dirty30.v
time ./dirty30
```
