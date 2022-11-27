;; Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.
;; [numbers stored in problem-13.txt]

(in-package :cl-euler)

(defun problem-13 ()
  (let* ((number-strings (uiop:read-file-lines "problem-13.txt"))
         (numbers (mapcar #'parse-integer number-strings))
         (sum-of-numbers (sum numbers))
         (sum-string (integer-to-string sum-of-numbers)))
    (subseq sum-string 0 10)))
