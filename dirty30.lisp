(declaim (optimize (safety 0) (debug 0) (speed 3)))

(defun hkeys (ht)
  (loop for k being the hash-keys of ht collect k))

(defun hvals (ht)
  (loop for v being the hash-values of ht collect v))

(defun repeat (n ch)
  (apply #'concatenate 'string (loop :repeat n :collect ch)))

(defun frequencies (roll-arr)
  (let ((ht (make-hash-table)))
    (loop :for roll :in roll-arr :do
      (let ((roll-count (gethash roll ht 0)))
        (setf (gethash roll ht) (+ 1 (nth-value 0 roll-count)))))
    ht))

(defun ascii-histogram (arr max-bar-length)
  (let* ((freqs (frequencies arr))
         (max-count (apply #'max (hvals freqs))))
    (loop :for val :in (sort (hkeys freqs) #'<) :do
      (let* ((freq (nth-value 0 (gethash val freqs)))
             (proportion (* 100.0 (/ freq (length arr))))
             (bar-str (repeat (* max-bar-length (/ freq max-count)) "+")))
        (format T "~,3d~6T~,5d~12T~,1f~18T~a~%" val freq proportion bar-str)))))

(defun mean (arr) (/ (reduce #'+ arr) (length arr)))

(defun rolld6 () (+ 1 (random 6)))

(defun dirty30-recursive (num-dice-left num-rolls)
  (if (= 0 num-dice-left)
    num-rolls
    (dirty30-recursive (length (remove-if-not (lambda (r) (< r 6))
                                              (loop :repeat num-dice-left :collect (rolld6))))
                       (+ 1 num-rolls))))

(defun dirty30 (num-dice)
  (dirty30-recursive num-dice 0))

(defun test-dirty30 ()
  (ascii-histogram (loop :for i :from 0 :to 100000 :collect (dirty30 30)) 40))

; (sb-ext:save-lisp-and-die #P"dirty30"
;                           :toplevel #'test-dirty30
;                           :executable t
;                           :compression 9)

(test-dirty30)
