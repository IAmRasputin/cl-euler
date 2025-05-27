;; Find the largest palindrome made from the product of two 3-digit numbers.
(in-package #:cl-euler)

(defsolution (4)
  (let ((max 0))
    (loop for x from 100 upto 999 do
      (loop for y from 100 upto 999 do
        (let ((product (* x y)))
          (when (and (is-palindrome (digits product))
                     (> product max))
            (setf max product)))))
    max))

(the-answer-is 4 906609)
