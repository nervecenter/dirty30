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
  (-> (math/random) (* 6) (math/ceil)))

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

(defn dirty30-iter [num-dice]
  (var remaining-dice num-dice)
  (var num-rolls 0)
  (var sixes 0)
  (while (> remaining-dice 0)
    (set sixes 0)
    (for _ 0 num-dice
      (if (= (rolld6) 6)
        (+= sixes 1)))
    (-= remaining-dice sixes)
    (+= num-rolls 1))
  num-rolls)

(-> (seq [_ :range [0 100000]]
      (dirty30-iter 30))
    (ascii_histogram 40))
