;; If we list all the natural numbers below 10 that are multiples of 3 or 5, we
;; get 3, 5, 6 and 9. The sum of these multiples is 23.

;; Find the sum of all the multiples of 3 or 5 below 1000.
(in-package #:cl-euler)

(defun multiple-of (factor x)
  (zerop (mod x factor)))

(defsolution (1)
  (let (acc)
    (dotimes (i 1000)
      (when (or (multiple-of 3 i) (multiple-of 5 i))
        (push i acc)))
    (apply #'+ acc)))
