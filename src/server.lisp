;;;; The server handlers for kudos-tracker.

(defpackage thanks-tracker-server
  (:documentation "The server handlers for kudos-tracker.")
  (:use :cl)
  (:export #:-run))

(in-package :thanks-tracker-server)

(defparameter kudos
  '(("Gaelan is awesome")
    ("Gaelan continues to be awesome")))

(defun -run ()
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 5000))
  (hunchentoot:define-easy-handler (slash-command :uri "/") (command text)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "~A~%~A" command text)))

; (defun -stop ())
