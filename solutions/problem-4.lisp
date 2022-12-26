;; Find the largest palindrome made from the product of two 3-digit numbers.

(in-package #:cl-euler)

(defun problem-4 ()
  (let ((products (make-hash-table :test #'equal)))
    ;; Use a hash table to record the products of every three-digit number
    (dotimes (pre-x (- 999 100))
      (dotimes (pre-y (- 999 100))
        ;; dotimes can only index from 0 so we have to offset it ourselves
        (let* ((x (+ 100 pre-x))
               (y (+ 100 pre-y))
               (hashed (gethash (cons x y) products)))
          (unless hashed
            (setf (gethash (cons x y) products) (* x y))))))
    ;; Do the thing with good-old-fashioned mapcar
    (let* ((products-list (alexandria:hash-table-values products))
           (stringified-products (mapcar #'integer-to-string products-list))
           (palindromes (remove-if-not #'is-palindrome stringified-products))
           (num-palindromes (mapcar #'parse-integer palindromes)))
      (apply #'max num-palindromes))))
