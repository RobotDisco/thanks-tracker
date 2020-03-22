;;;; The server handlers for kudos-tracker.

(defpackage thanks-tracker-server
  (:documentation "The server handlers for kudos-tracker.")
  (:use :cl)
  (:export #:-run
	   #:-stop))

(in-package :thanks-tracker-server)

(defparameter kudos
  '(("Gaelan is awesome")
    ("Gaelan continues to be awesome")))

(defvar *handler* nil)

(defun app (env)
  (declare (ignore env))
  '(200 (:content-type "text/plain") ("Hello, Clack!")))

(defun -run ()
  (setq *handler* (clack:clackup #'app)))

(defun -stop ()
  (when *handler*
    (clack:stop *handler*)))


(-stop)
(-run)
