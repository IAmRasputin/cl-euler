(in-package :cl-euler)

;; What is the value of the first triangle number to have over five hundred divisors?

(defun problem-12 ()
  (do* ((index 1 (1+ index))
        (nth-triangle (nth-triangle-num index)
                      (nth-triangle-num index))
        (factors (number-of-divisors nth-triangle)
                 (number-of-divisors nth-triangle)))
       ((> factors 500) nth-triangle)))
