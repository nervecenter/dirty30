(defn ascii_histogram [arr max-bar-length]
  (let [freqs (frequencies arr)
        max-count (apply max (vals freqs))]
    (doseq [val (sort (keys freqs))]
      (let [freq (get freqs val)
            val-str (format "%3d" val)
            freq-str (format "%5d" freq)
            proportion-str (format "%.1f" (* 100.0 (/ freq (count arr))))
            bar-str (as-> freq b
                          (/ b max-count)
                          (* max-bar-length b)
                          (int b)
                          (repeat b "+")
                          (apply str b))]
        (println val-str freq-str proportion-str "\t" bar-str)))))

(defn mean [arr] (/ (reduce + arr) (count arr)))

(defn rolld6 [] (inc (rand-int 6)))

(defn dirty30 [num-dice]
  (loop [num-dice-left num-dice
         num-rolls 0]
    (if (zero? num-dice-left)
      num-rolls
      (recur (->> (repeatedly num-dice-left rolld6)
                  (filter #(< % 6))
                  count)
             (inc num-rolls)))))

(ascii_histogram (repeatedly 100000 #(dirty30 30)) 40)
