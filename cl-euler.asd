(asdf:defsystem "cl-euler"
  :description "Project Euler"
  :version "0.0.1"
  :license "GPLv3"
  :depends-on ("alexandria" "log4cl")
  :components ((:file "package")
               (:file "util")
               (:file "problem-1")
               (:file "problem-2")
               (:file "problem-3")
               (:file "problem-4")
               (:file "problem-5")
               (:file "problem-6")
               (:file "problem-7")
               (:file "problem-8")
               (:file "problem-9")
               (:file "problem-10")
               (:file "problem-11")))
