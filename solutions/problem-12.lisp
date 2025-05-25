(in-package :cl-euler)

;; What is the value of the first triangle number to have over five hundred divisors?

(defun problem-12 ()
  ;; making triangle numbers on the fly
  (do* ((i 1 (1+ i))
        (sum 1 (+ sum i))
        (factors (all-factors sum)
                 (all-factors sum)))
      ((> (length factors) 500) sum)))
