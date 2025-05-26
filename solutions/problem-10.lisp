;; Find the sum of all the primes below two million.

(in-package :cl-euler)

(defsolution (10)
  (load-primes-until 2000000)
  (let ((sum 0))
    (dovector (prime  *prime-numbers*)
      (when (>= prime 2000000)
        (return))
      (incf sum prime))
    sum))
