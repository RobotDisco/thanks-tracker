;;;; The server handlers for kudos-tracker.

(defpackage thanks-tracker-server
  (:documentation "The server handlers for kudos-tracker.")
  (:use :cl)
  (:export #:-run))

(in-package :thanks-tracker-server)

(defun -run ()
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 5000))
  (hunchentoot:define-easy-handler (slash-command :uri "/") (command text)
  (setf (hunchentoot:content-type*) "text/json")
  (json:encode-json (list
		     (cons 'command command)
		     (cons 'text text)))))

; (defun -stop ())
