(in-package :cl-euler)

;; What is the value of the first triangle number to have over five hundred divisors?

(defvar *triangle-cache* (make-hash-table))

(defun nth-triangle (n)
  (or (gethash n *triangle-cache*)
      (setf (gethash n *triangle-cache*)
            (apply #'+ (range 1 n)))))

(defun problem-12 ()
  (do* ((index 1 (1+ index))
        (nth-triangle-num (nth-triangle index)
                          (nth-triangle index))
        (factors (all-factors nth-triangle-num)
                 (all-factors nth-triangle-num)))
       ((> (length factors) 500) nth-triangle-num)
    (format t "~16d: ~d has ~d factors~&" index nth-triangle-num (length factors))))
