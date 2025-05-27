;; By considering the terms in the Fibonacci sequence whose values do not exceed
;; four million, find the sum of the even-valued terms.
(in-package :cl-euler)

(defun fibonacci-until (limit)
  (let ((seq '(1 2))
        (next 3))
    (until (> next limit)
      (setf seq (append seq (list next))
            next (apply #'+ (last seq 2))))
    seq))

(defsolution (2)
  (apply #'+ (remove-if #'oddp (fibonacci-until 4000000))))

(the-answer-is 2 4613732)
