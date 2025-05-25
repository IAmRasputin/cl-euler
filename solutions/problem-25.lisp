(in-package :cl-euler)

(defun problem-25 ()
  (do* ((sum-next nil (+ fn-1 fn))
        (fn-2 1 fn-1)
        (fn-1 1 fn)
        (fn 2 sum-next)
        (idx 3 (1+ idx)))
      ((= 1000 (1+ (floor (log fn 10)))))))

