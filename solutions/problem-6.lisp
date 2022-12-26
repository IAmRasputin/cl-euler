;; Find the difference between the sum of the squares of the first one hundred
;; natural numbers and the square of the sum.

(in-package :cl-euler)

(defun sum-of-squares (seq)
  (labels ((square (x) (* x x)))
    (apply #'+ (mapcar #'square seq))))

(defun square-of-sum (seq)
  (let ((sum (apply #'+ seq)))
    (* sum sum)))

(defun problem-6 ()
  (let ((numbers (range 1 100)))
    (abs (- (sum-of-squares numbers) (square-of-sum numbers)))))
