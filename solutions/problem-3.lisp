;; What is the largest prime factor of the number 600851475143 ?

(in-package :cl-euler)

;; Good news!  There's neato code for generating prime numbers in util.lisp

(defsolution (3)
  (apply #'max (prime-factors 600851475143)))

(the-answer-is 3 4613732)
