(defsystem "thanks-tracker"
  :author "Gaelan D'costa <gdcosta@gmail.com>"
  :maintainer "Gaelan D'costa <gdcosta@gmail.com>"
  :version "0.0.0"
  :license "General Public License, Version 3 (see file COPYING for details)"
  :homepage "https://github.com/RobotDisco/thanks-tracker"
  :bug-tracker "https://github.com/RobotDisco/thanks-tracker/issues"
  :description "A service to give people thanks in mattermost channels"
  :long-description #.(uiop:read-file-string
		       (uiop:subpathname *load-pathname* "README.org"))
  :components ((:module "src" :components ((:file "db")
					   (:file "server"))))
  :in-order-to ((test-op (test-op "thanks-tracker/tests")))
  :depends-on ("bordeaux-threads" "hunchentoot" "cl-json" "str")
  :build-operation "program-op"
  :build-pathname "bin/thanks-tracker"
  :entry-point "thanks-tracker-server:main")

(defsystem "thanks-tracker/tests"
  :author "Gaelan D'costa <gdcosta@gmail.com>"
  :maintainer "Gaelan D'costa <gdcosta@gmail.com>"
  :license "General Public License, Version 3 (see file COPYING for details)"
  :source-control (:git "git@github.com:RobotDisco/thanks-tracker.git")
  :depends-on ("thanks-tracker"
	       "rove")
  :components ((:module "tests" :components ((:file "thanks-tracker"))))
  :description "Test system for thanks-tracker"
  :perform (test-op (op c) (symbol-call :rove :run c)))
