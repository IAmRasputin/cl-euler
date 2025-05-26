;; There exists exactly one Pythagorean triplet for which a + b + c = 1000.
;; Find the product abc.
(in-package :cl-euler)

(defun is-pythagorean-triplet (a b c)
  "Returns t if it's a pythagorean triplet, NIL otherwise"
  (and (< a b c)
       (= (* c c)
          (+ (* a a)
             (* b b)))))

(defun find-third (a b)
  (multiple-value-bind (int leftover) (floor (sqrt (+ (* a a)
                                                      (* b b))))
    (when (zerop leftover)
      int)))


(defun correct-sum-candidates ()
  "All sets of three integers A B C where:
   -- A < B < C and
   -- A + B + C = 1000"
  (let (candidates)
    (dotimes (first-number 1000)
      (dotimes (second-number 1000)
        (let ((third-number (find-third first-number second-number)))
          (if (and third-number
                   (= 1000 (+ first-number
                              second-number
                              third-number))
                   (< first-number
                      second-number
                      third-number))
              (push (list first-number
                          second-number
                          third-number)
                    candidates)))))
    candidates))

(defsolution (9)
  (apply #'* (first (correct-sum-candidates))))
