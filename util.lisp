(in-package :cl-euler)

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
(defun range (start end)
  (if (= start end)
      (list end)
      (cons start (range (if (> start end)
                             (- start 1)
                             (+ start 1))
                         end))))
