(def rng (math/rng (os/time)))

(defn ascii_histogram [arr &opt max-bar-length]
  (default max-bar-length 30)
  (let [freqs (frequencies arr)
        max-count (->> freqs (values) (apply max))]
    (each val (-> freqs (keys) (sorted))
      (let [freq (get freqs val)
            proportion (/ freq (length arr))
            bar-len (-> freq (/ max-count) (* max-bar-length) (math/ceil))]
        (printf "%3d\t%5d\t%.1f%%\t%s"
                val
                freq
                (* 100.0 proportion)
                (string/repeat "+" bar-len))))))

(defn rolld6 []
  (-> (math/rng-int rng 6) (+ 1)))

(defn rollnd6 [n]
  (seq [_ :range [0 n]]
    (rolld6)))

(defn dirty30 [num-dice &opt num-rolls]
  (default num-rolls 0)
  (if (zero? num-dice)
    num-rolls
    (dirty30 (->> (rollnd6 num-dice)
                  (filter (fn [roll] (< roll 6)))
                  length)
             (inc num-rolls))))

(defn dirty30-iter [&opt num-dice]
  (default num-dice 30)
  (var remaining-dice num-dice)
  (var num-rolls 0)
  (var sixes 0)
  (while (> remaining-dice 0)
    (set sixes 0)
    (for _ 0 remaining-dice
      (if (= (rolld6) 6)
        (+= sixes 1)))
    (-= remaining-dice sixes)
    (+= num-rolls 1))
  num-rolls)

(def num-games 100000)
(def num-threads 20)
(def games-per-worker (/ num-games num-threads))
(var thread-results (ev/thread-chan 20))

(defn game-runner []
  (let [results (-> (seq [_ :range [0 games-per-worker]]
                    (dirty30-iter)))]
    (ev/give thread-results results)))

(var games-results @[])
(for _ 0 num-threads (ev/spawn-thread (game-runner)))
(for _ 0 num-threads
  (array/concat games-results (ev/take thread-results)))

(ascii_histogram games-results 40)
