;; What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

(in-package :cl-euler)

(defun problem-5 ()
  ;; Not putting this one in the utils, too specific
  (declare (optimize (speed 3) (safety 0) (space 0) (debug 0)))
  (labels ((divisible-by-all (n)
             (dotimes (count 18)
               (unless (zerop (mod n (+ 2 count)))
                 (return-from divisible-by-all nil)))
             t))
    (do* ((index 1 (+ index 1)))
         ((divisible-by-all index) index))))
