#lang racket

(require threading)
(require algorithms)
(require list-utils)

(define (ascii-histogram arr [max-bar-length 30])
  (let* ([freqs (frequencies arr)]
         [max-count (apply max (hash-values freqs))])
    (for ([val (sort (hash-keys freqs) <)])
      (let* ([freq (hash-ref freqs val)]
             [proportion (* 100.0 (/ freq (length arr)))]
             [bar-str (~> freq
                          (/ max-count)
                          (* max-bar-length)
                          (floor)
                          (make-string #\+))])
        (printf "~a\t~a\t~a\t~a\n" (~a val #:min-width 3)
                                   (~a freq #:min-width 5)
                                   (~r proportion #:precision 1)
                                   bar-str)))))

(define (rolld6) (random 1 7))

(define (rollnd6 n) (for/list ([i n]) (rolld6)))

(define (dirty30 num-dice [num-rolls 0])
  (if (zero? num-dice)
    num-rolls
    (dirty30 (~>> (rollnd6 num-dice)
                  (filter (lambda (r) (< r 6)))
                  length)
             (+ 1 num-rolls))))

(ascii-histogram (for/list ([i 100000]) (dirty30 30)) 40)
