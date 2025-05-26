(in-package :cl-euler)

(defvar *solutions* (make-hash-table))

(defun register-solution (problem-num fn)
  (setf (gethash problem-num *solutions*) fn))

(defun run-solution (problem-num)
  (funcall (gethash problem-num *solutions*)))

(defmacro defsolution ((problem-num) &body body)
  `(register-solution ,problem-num (lambda () ,@body)))
