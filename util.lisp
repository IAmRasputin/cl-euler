(in-package :cl-euler)

;; Logging

;; Loops

(defmacro while (condition &body body)
  `(do ()
       ((not ,condition))
     ,@body))

(defmacro until (condition &body body)
  `(do ()
       (,condition)
     ,@body))

;; Vectors

(defmacro dovector ((var vector-exp &optional result-form) &body body)
  `(do* ((vec-dov ,vector-exp)
         (len-dov (length vec-dov))
         (i-dov 0 (+ i-dov 1))
         (,var nil))
        ((equal i-dov len-dov) ,result-form)
     (setf ,var (aref vec-dov i-dov))
     ,@body))

(defun vlast (vec)
  (aref vec (- (length vec) 1)))

;; Primes

(defvar *prime-numbers*
  (make-array 3 :adjustable t :fill-pointer t :initial-contents '(2 3 5)))

(defun find-next-prime ()
  ;; Where we're going, we don't need even numbers
  ;; Given the primes in *prime-numbers*, find the next one, return it (don't append, be functional)
  (do* ((candidate (+ 2 (vlast *prime-numbers*)))
        (check-limit (sqrt candidate)
                     (sqrt candidate))
        (success nil))
       (success candidate)
    (dovector (prime *prime-numbers*)
      (cond
        ((zerop (mod candidate prime)) (progn
                                         (setf candidate (+ 2 candidate))
                                         (return)))
        ((> prime check-limit) (progn
                                 (setf success t)
                                 (return)))))))

(defun load-next-prime (&optional (n 1))
  (dotimes (i n)
    (vector-push-extend (find-next-prime) *prime-numbers*))
  *prime-numbers*)


(defun load-primes-until (n)
  (while (>= n (vlast *prime-numbers*))
    (load-next-prime)))

(defun is-prime (n)
  (when (> n (vlast *prime-numbers*))
    (load-primes-until n))
  (not (null (find n *prime-numbers*))))


(defun prime-factors (n)
  (dovector (prime *prime-numbers*)
    (when (> prime n)
      (load-next-prime 100))
    (when (zerop (mod n prime))
      (return (cons prime (prime-factors (/ n prime)))))))

(defun all-factors (n)
  (let (factors)
    (dolist (i (range 1 (ceiling (/ n 2))))
      (when (zerop (mod n i))
        (push i factors)))
    (push n factors)
    (nreverse (remove-duplicates factors))))

(defun number-of-divisors (num)
  "Shamelessly copied from a c-ish algorith on the internet"
  ;; Maybe someday I'll really wrap my head around this and make it more lispy
  (let ((n num)
        (i 2)
        (p 1))
    (if (= 1 n)
        1
        (progn
          (while (<= (* i i) n)
            (let ((c 1))
              (while (zerop (mod n i))
                (setf n (floor (/ n i)))
                (incf c))
              (incf i)
              (setf p (* p c))))
          (when (or (= n num) (> n 1))
            (setf p (* p 2)))
          p))))

;; Triangle numbers (seems familiar...)
(defvar *triangle-numbers*
  (make-array 10
              :initial-contents '(nil 1 3 6 10 15 21 28 36 45)
              :adjustable t
              :fill-pointer t))

(defun find-next-triangle-number ()
  ;; Given the triangles in *triangle-numbers*, find the next one, return it (don't append, be functional)
  (+ (length *triangle-numbers*) (vlast *triangle-numbers*)))

(defun load-next-triangle-number (&optional (n 1))
  (dotimes (i n)
    (vector-push-extend (find-next-triangle-number) *triangle-numbers*))
  *triangle-numbers*)


(defun load-triangle-numbers-until (n)
  (let ((len (length *triangle-numbers*)))
    (while (>= n len)
      (load-next-triangle-number))))

(defun is-triangle-number (n)
  (when (> n (vlast *triangle-numbers*))
    (load-triangle-numbers-until n))
  (not (null (find n *triangle-numbers*))))

(defun nth-triangle-num (n)
  (let ((tri-num-len (length *triangle-numbers*)))
    (if (< n tri-num-len)
        (progn
          (aref *triangle-numbers* n))
        (progn
          (load-triangle-numbers-until (+ tri-num-len 10))
          (aref *triangle-numbers* n)))))

;; Strings

(defun integer-to-string (n)
  (format nil "~d" n))

(defun is-palindrome (str)
  (do* ((head-pointer 0
                      (1+ head-pointer))
        (tail-pointer (- (length str) 1)
                      (- tail-pointer 1)))
       ((>= head-pointer tail-pointer) t)
    (unless (char= (aref str head-pointer)
                   (aref str tail-pointer))
      (return nil))))

;; Lists
(defun range (start end &optional (step 1))
  (cond
    ((= start end) (list start))
    ((> start end) (loop for n from start downto end by step
                         collect n))
    ((< start end) (loop for n from start upto end by step
                         collect n))))


(defun sum (seq)
  (apply #'+ seq))
