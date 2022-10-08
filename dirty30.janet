(defn ascii_histogram [arr &opt max-bar-length]
  (default max-bar-length 30)
  (let [freqs (frequencies arr)
        max-count (apply max (values freqs))]
    (each val (sort (keys freqs))
      (let [freq (get freqs val)
            proportion (/ freq (length arr))
            val-str (string/format "%3d\t" val)
            freq-str (string/format "%5d\t" freq)
            proportion-str (string/format "%.1f%%\t" (* 100.0 proportion))
            bar-str (as-> freq b
                          (/ b max-count)
                          (* max-bar-length b)
                          (seq [_ :range [0 b]] "+")
                          (string/join b))]
        (print val-str freq-str proportion-str "\t" bar-str)))))

(defn mean [arr] (/ (reduce2 + arr) (length arr)))

(defn rolld6 [] (math/ceil (* 6 (math/random))))

(defn rollnd6 [n] (seq [_ :range [0 n]] (rolld6)))

(defn dirty30 [num-dice &opt num-rolls]
  (default num-rolls 0)
  (if (zero? num-dice)
    num-rolls
    (dirty30 (->> (rollnd6 num-dice)
                  (filter (fn [roll] (< roll 6)))
                  length)
             (inc num-rolls))))

(ascii_histogram (seq [_ :range [0 100000]] (dirty30 30)) 40)
