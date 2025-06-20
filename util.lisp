(in-package :cl-euler)

;; Files
(defun read-file-lines (filepath)
  (uiop:read-file-lines (asdf:system-relative-pathname :cl-euler filepath)))

(defun read-file-string (filepath)
  (uiop:read-file-string (asdf:system-relative-pathname :cl-euler filepath)))

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

(defun prime-factors (num)
  (load-primes-until (ceiling (sqrt num)))
  (labels ((factorize (n)
             (dovector (prime *prime-numbers*)
               (when (> prime n)
                 (return nil))
               (when (zerop (mod n prime))
                 (return (cons prime (factorize (/ n prime))))))))
    (let ((factors (factorize num)))
      (unless (equal factors (list num))
        (factorize num)))))

(defun load-primes-until (n)
  (while (>= n (vlast *prime-numbers*))
    (load-next-prime)))

(defun is-prime (n)
  (when (> n (vlast *prime-numbers*))
    (load-primes-until n))
  (not (null (find n *prime-numbers*))))

(defun prime-factors (n)
  (load-primes-until (ceiling (sqrt n))))

(defun all-factors (n)
  (let (factors)
    (dolist (i (range 1 (ceiling (sqrt n))))
      (when (zerop (mod n i))
        (push i factors)
        (push (/ n i) factors)))
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

(defun nth-triangle-num (n)
  (alexandria:binomial-coefficient (1+ n) 2))

;; Integer gymnastics

(defun integer-to-string (n)
  (format nil "~d" n))

(defun digit-length (n)
  (ceiling (log n 10)))

(defun digits (num)
  (cond
    ((< num 0) (digits (abs num)))
    ((zerop num) '(0))
    (t 
     (let* ((len (digit-length num))
            (digits (loop for i from len downto 0 collect
                     (mod (floor (/ num (expt 10 i))) 10))))
       (if (zerop (first digits))
           (cdr digits)
           digits)))))

(defun is-palindrome (seq)
  (equal seq (reverse seq)))

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
