(in-package :cl-euler)

;; for testing after a refactor
(defun test (problem-num)
  (format t "Problem ~d: " problem-num)
  (let ((solution-fn (gethash problem-num *solutions*))
        (answer (gethash problem-num *answers*)))
    (if solution-fn
      (let ((solution (funcall solution-fn))) 
        (if answer
            (format t "Got ~d. Expected ~d. ~:[FAIL~;PASS~] ~%" solution answer (= solution answer))
            (format t "Got ~d. No answer registered.~%" solution)))
        (format t "No solution registered.~%"))))
