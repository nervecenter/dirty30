# dirty30

A fantasy gambling game implemented in numerous novel languages. Compare performance between. Includes a number of common data manipulation tasks:

- Run a procedure a large number times
- Generate die rolls a dynamic number of times
- Collect results into a sequence
- Generate a hash map histogram of that sequence
- Format and print the histogram

## Clojure

`time clojure dirty30.clj`

## Common Lisp

`time sbcl --script dirty30.lisp`

## D

```bash
dmd dirty30.d
time ./dirty30
```

Be sure to run it a couple extra times, the first time will compile and cache an executable.

# Janet

`time janet dirty30.janet`

# Nim

```bash
nim c dirty30.nim
time ./dirty30
```

# Python

`time python dirty30.py`

# Racket

`time racket dirty30.rkt`
