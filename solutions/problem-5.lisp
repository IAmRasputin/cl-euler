;; What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

(in-package :cl-euler)

(defsolution (5)
  ;; Not putting this one in the utils, too specific
  (labels ((divisible-by-all (n)
             (dotimes (count 18)
               (unless (zerop (mod n (+ 2 count)))
                 (return-from divisible-by-all nil)))
             t))
    (do* ((index 20 (+ index 20)))
        ((divisible-by-all index) index))))
