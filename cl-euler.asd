(asdf:defsystem "cl-euler"
  :description "Project Euler"
  :version "0.0.1"
  :license "GPLv3"
  :depends-on ("alexandria")
  :components ((:file "package")
               (:file "util")
               (:file "problem-1")
               (:file "problem-2")
               (:file "problem-3")
               (:file "problem-4")
               (:file "problem-5")))
