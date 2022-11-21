;; What is the 10 001st prime number?

(in-package :cl-euler)

(defun problem-7 ()
  (let ((size (length *prime-numbers*)))
    (when (> 10001 size)
      (load-next-prime (- 10001 size)))
    (aref *prime-numbers* 10000)))
